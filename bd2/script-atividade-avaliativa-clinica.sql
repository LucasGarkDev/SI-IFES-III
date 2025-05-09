-- 🧱 Parte 1 – Criação das Tabelas (DROP e CRIAÇÃO BASE)

DROP TABLE IF EXISTS EXAME_PEDIDO CASCADE;
DROP TABLE IF EXISTS EXAME CASCADE;
DROP TABLE IF EXISTS MATERIAL CASCADE;
DROP TABLE IF EXISTS PEDIDO CASCADE;
DROP TABLE IF EXISTS PEDIDO_CONTROLE CASCADE;
DROP TABLE IF EXISTS MEDICO CASCADE;
DROP TABLE IF EXISTS CLIENTE CASCADE;
DROP TABLE IF EXISTS PLANO CASCADE;
DROP TABLE IF EXISTS VALOR_US CASCADE;
DROP TABLE IF EXISTS FATURA CASCADE;
DROP TABLE IF EXISTS EXAME_AUTORIZADO CASCADE;

-- TABELA: MATERIAL
CREATE TABLE MATERIAL (
    idMaterial SERIAL PRIMARY KEY,
    descricao TEXT NOT NULL
);

-- TABELA: EXAME
CREATE TABLE EXAME (
    idExame SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    idMaterial INTEGER REFERENCES MATERIAL(idMaterial),
    dias_previsao INTEGER
);

-- TABELA: MEDICO
CREATE TABLE MEDICO (
    idMedico SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    CRM VARCHAR(20) NOT NULL
);

-- TABELA: CLIENTE
CREATE TABLE CLIENTE (
    idCliente SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    sexo CHAR(1),
    nascimento DATE
);

-- TABELA: PLANO
CREATE TABLE PLANO (
    idPlano SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    perc_cliente NUMERIC(5,2)
);

-- TABELA: VALOR_US
CREATE TABLE VALOR_US (
    idPlano INTEGER REFERENCES PLANO(idPlano),
    data_inicial_vigencia DATE,
    data_final_vigencia DATE,
    valor NUMERIC(10,2),
    PRIMARY KEY (idPlano, data_inicial_vigencia)
);

-- TABELA: FATURA
CREATE TABLE FATURA (
    nr_fatura SERIAL PRIMARY KEY,
    idPlano INTEGER REFERENCES PLANO(idPlano),
    data_geracao DATE,
    data_envio DATE,
    data_pagamento DATE
);

-- TABELA: EXAME_AUTORIZADO
CREATE TABLE EXAME_AUTORIZADO (
    idPlano INTEGER REFERENCES PLANO(idPlano),
    idExame INTEGER REFERENCES EXAME(idExame),
    valor_ch NUMERIC(10,2),
    PRIMARY KEY (idPlano, idExame)
);

-- 🔧 TABELA DE CONTROLE PARA GERAR NR_PEDIDO
CREATE TABLE PEDIDO_CONTROLE (
    nrPedido SERIAL PRIMARY KEY
);

-- 🧩 Parte 2 – Particionamento de PEDIDO por RANGE de data_pedido

CREATE TABLE PEDIDO (
    nrPedido INTEGER,
    data_pedido DATE NOT NULL,
    idMedico INTEGER REFERENCES MEDICO(idMedico),
    idCliente INTEGER REFERENCES CLIENTE(idCliente),
    idPlano INTEGER NOT NULL REFERENCES PLANO(idPlano),
    PRIMARY KEY (nrPedido, data_pedido)
) PARTITION BY RANGE (data_pedido);

CREATE TABLE PEDIDO_2024 PARTITION OF PEDIDO
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- TABELA: EXAME_PEDIDO (particionada por data_prevista)
CREATE TABLE EXAME_PEDIDO (
    nrPedido INTEGER,
    data_pedido DATE NOT NULL,
    idExame INTEGER REFERENCES EXAME(idExame),
    data_prevista DATE NOT NULL,
    nr_autorizacao VARCHAR(50),
    data_coleta DATE,
    data_efetiva DATE,
    valor NUMERIC(10,2),
    nr_fatura INTEGER,
    plano INTEGER,
    PRIMARY KEY (nrPedido, data_pedido, idExame, data_prevista),
    FOREIGN KEY (nrPedido, data_pedido) REFERENCES PEDIDO(nrPedido, data_pedido)
) PARTITION BY RANGE (data_prevista);

CREATE TABLE EXAME_PEDIDO_2024 PARTITION OF EXAME_PEDIDO
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- 🔍 Parte 3 – Índices

CREATE INDEX idx_exame_material ON EXAME(idMaterial);
CREATE INDEX idx_valor_ls_periodo ON VALOR_US(data_inicial_vigencia, data_final_vigencia);
CREATE INDEX idx_examepedido_data ON EXAME_PEDIDO(data_prevista);
CREATE INDEX idx_pedido_cliente ON PEDIDO(idCliente);
CREATE INDEX idx_pedido_data ON PEDIDO(data_pedido);

-- 🧮 Parte 4 – Função CALCULA_VALOR_EXAMES_CLIENTES

CREATE OR REPLACE FUNCTION CALCULA_VALOR_EXAMES_CLIENTES(p_mes INT, p_ano INT)
RETURNS NUMERIC AS $$
DECLARE
    total_valor NUMERIC := 0;
BEGIN
    SELECT SUM(ep.valor)
    INTO total_valor
    FROM EXAME_PEDIDO ep
    JOIN PEDIDO p ON ep.nrPedido = p.nrPedido AND ep.data_pedido = p.data_pedido
    WHERE EXTRACT(MONTH FROM p.data_pedido) = p_mes
      AND EXTRACT(YEAR FROM p.data_pedido) = p_ano
      AND ep.plano IS NULL;

    RETURN COALESCE(total_valor, 0);
END;
$$ LANGUAGE plpgsql;

-- 📝 Parte 5 – Função INSERE_PEDIDO

CREATE OR REPLACE FUNCTION INSERE_PEDIDO(
    p_idMedico INTEGER,
    p_idCliente INTEGER,
    p_idPlano INTEGER
) RETURNS INTEGER AS $$
DECLARE
    novo_pedido INTEGER;
BEGIN
    -- Verificações
    IF NOT EXISTS (SELECT 1 FROM MEDICO WHERE idMedico = p_idMedico) THEN
        RAISE EXCEPTION 'Médico não encontrado.';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM CLIENTE WHERE idCliente = p_idCliente) THEN
        RAISE EXCEPTION 'Cliente não encontrado.';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM PLANO WHERE idPlano = p_idPlano) THEN
        RAISE EXCEPTION 'Plano não encontrado.';
    END IF;

    -- Geração de nrPedido
    INSERT INTO PEDIDO_CONTROLE DEFAULT VALUES RETURNING nrPedido INTO novo_pedido;

    -- Inserção na tabela particionada
    INSERT INTO PEDIDO (nrPedido, data_pedido, idMedico, idCliente, idPlano)
    VALUES (novo_pedido, CURRENT_DATE, p_idMedico, p_idCliente, p_idPlano);

    RETURN novo_pedido;
END;
$$ LANGUAGE plpgsql;

-- 🧮 Parte 6 – STORED PROCEDURE INSERE_EXAME_PEDIDO

CREATE OR REPLACE PROCEDURE INSERE_EXAME_PEDIDO(
    p_nrPedido INTEGER,
    p_dataPedido DATE,
    p_idExame INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    id_plano INTEGER;
    valor_us NUMERIC;
    valor_ch NUMERIC;
BEGIN
    -- Verifica se o pedido existe e obtém o idPlano
    SELECT idPlano INTO id_plano
    FROM PEDIDO
    WHERE nrPedido = p_nrPedido AND data_pedido = p_dataPedido;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Pedido não encontrado';
    END IF;

    -- Verifica se o exame existe
    IF NOT EXISTS (SELECT 1 FROM EXAME WHERE idExame = p_idExame) THEN
        RAISE EXCEPTION 'Exame não encontrado';
    END IF;

    -- Verifica se o exame está autorizado para o plano do pedido
    SELECT valor_ch INTO valor_ch
    FROM EXAME_AUTORIZADO
    WHERE idPlano = id_plano AND idExame = p_idExame;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Exame não autorizado para este plano';
    END IF;

    -- Recupera o valor atual do US
    SELECT valor INTO valor_us
    FROM VALOR_US
    WHERE idPlano = id_plano
      AND CURRENT_DATE BETWEEN data_inicial_vigencia AND data_final_vigencia
    LIMIT 1;

    IF valor_us IS NULL THEN
        RAISE EXCEPTION 'Valor US não encontrado para o plano na data atual';
    END IF;

    -- Inserção do exame vinculado ao pedido
    INSERT INTO EXAME_PEDIDO (
        nrPedido, data_pedido, idExame, data_prevista, valor
    ) VALUES (
        p_nrPedido, p_dataPedido, p_idExame, CURRENT_DATE, valor_ch * valor_us
    );
END;
$$;

-- 🛑 Parte 7 – RULE para impedir exame de gravidez (Beta-HCG) para homens

CREATE OR REPLACE RULE impedir_gravidez_homens AS
ON INSERT TO EXAME_PEDIDO
WHERE (
    NEW.idExame = (SELECT idExame FROM EXAME WHERE nome ILIKE '%beta-hcg%' LIMIT 1)
    AND EXISTS (
        SELECT 1 FROM PEDIDO p
        JOIN CLIENTE c ON p.idCliente = c.idCliente
        WHERE p.nrPedido = NEW.nrPedido AND p.data_pedido = NEW.data_pedido AND c.sexo = 'M'
    )
)
DO INSTEAD NOTHING;

-- 🛑 Parte 8 – RULE para impedir gravidez para mulheres com 65 anos ou mais

CREATE OR REPLACE RULE impedir_gravidez_idosas AS
ON INSERT TO EXAME_PEDIDO
WHERE (
    NEW.idExame = (SELECT idExame FROM EXAME WHERE nome ILIKE '%beta-hcg%' LIMIT 1)
    AND EXISTS (
        SELECT 1 FROM PEDIDO p
        JOIN CLIENTE c ON p.idCliente = c.idCliente
        WHERE p.nrPedido = NEW.nrPedido AND p.data_pedido = NEW.data_pedido
          AND c.sexo = 'F'
          AND AGE(c.nascimento) >= INTERVAL '65 years'
    )
)
DO INSTEAD NOTHING;

-- 🛑 Parte 9 – RULE para impedir exame de próstata (PSA) para mulheres

CREATE OR REPLACE RULE impedir_psa_mulheres AS
ON INSERT TO EXAME_PEDIDO
WHERE (
    NEW.idExame = (SELECT idExame FROM EXAME WHERE nome ILIKE '%psa%' LIMIT 1)
    AND EXISTS (
        SELECT 1 FROM PEDIDO p
        JOIN CLIENTE c ON p.idCliente = c.idCliente
        WHERE p.nrPedido = NEW.nrPedido AND p.data_pedido = NEW.data_pedido AND c.sexo = 'F'
    )
)
DO INSTEAD NOTHING;

-- 🔄 Parte 10 – PROCEDURE FECHAR_FATURA_MES

CREATE OR REPLACE PROCEDURE FECHAR_FATURA_MES(
    p_mes INT,
    p_ano INT,
    p_idPlano INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    nova_fatura_id INTEGER;
BEGIN
    -- Cria nova fatura
    INSERT INTO FATURA (idPlano, data_geracao)
    VALUES (p_idPlano, CURRENT_DATE)
    RETURNING nr_fatura INTO nova_fatura_id;

    -- Atualiza exames ainda não faturados
    UPDATE EXAME_PEDIDO ep
    SET nr_fatura = nova_fatura_id
    FROM PEDIDO p
    WHERE ep.nr_fatura IS NULL
      AND ep.nrPedido = p.nrPedido
      AND ep.data_pedido = p.data_pedido
      AND EXTRACT(MONTH FROM p.data_pedido) = p_mes
      AND EXTRACT(YEAR FROM p.data_pedido) = p_ano
      AND p.idPlano = p_idPlano;
END;
$$;
