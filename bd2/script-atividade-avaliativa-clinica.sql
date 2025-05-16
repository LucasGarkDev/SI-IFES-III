-- 🧱 Parte 1 – Criação das Tabelas (DROP e CRIAÇÃO BASE)
DROP TABLE IF EXISTS EXAME_PEDIDO CASCADE;
DROP TABLE IF EXISTS EXAME CASCADE;
DROP TABLE IF EXISTS MATERIAL CASCADE;
DROP TABLE IF EXISTS PEDIDO CASCADE;
DROP TABLE IF EXISTS MEDICO CASCADE;
DROP TABLE IF EXISTS CLIENTE CASCADE;
DROP TABLE IF EXISTS PLANO CASCADE;
DROP TABLE IF EXISTS VALOR_US CASCADE;
DROP TABLE IF EXISTS FATURA CASCADE;
DROP TABLE IF EXISTS EXAME_AUTORIZADO CASCADE;
DROP SEQUENCE IF EXISTS seq_nrPedido;

-- 🔢 Criação da sequência para NR_PEDIDO
CREATE SEQUENCE seq_nrPedido START 1;

-- TABELA: MATERIAL
CREATE TABLE MATERIAL (
    idMaterial SERIAL PRIMARY KEY,
    descricao TEXT NOT NULL
);

-- Exemplos:
INSERT INTO MATERIAL (descricao) VALUES ('Sangue'), ('Urina');

-- Verificando dados inseridos:
SELECT * FROM MATERIAL;

-- TABELA: EXAME
CREATE TABLE EXAME (
    idExame SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    idMaterial INTEGER REFERENCES MATERIAL(idMaterial),
    dias_previsao INTEGER
);

-- Exemplos:
INSERT INTO EXAME (nome, idMaterial, dias_previsao)
VALUES 
  ('Hemograma Completo', 1, 2),
  ('Beta-HCG', 2, 3),
  ('PSA - Antígeno Prostático Específico', 1, 2);

-- Verificando dados inseridos:
SELECT * FROM EXAME;

-- TABELA: MEDICO
CREATE TABLE MEDICO (
    idMedico SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    CRM VARCHAR(20) NOT NULL
);

-- Exemplos:
INSERT INTO MEDICO (nome, CRM) VALUES ('Dr. João Silva', '123456-ES');

-- Verificando dados inseridos:
SELECT * FROM MEDICO;

-- TABELA: CLIENTE
CREATE TABLE CLIENTE (
    idCliente SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    sexo CHAR(1),
    nascimento DATE
);

-- Exemplos:
INSERT INTO CLIENTE (nome, sexo, nascimento)
VALUES
  ('Ana Paula', 'F', '1990-05-10'),
  ('Carlos Eduardo', 'M', '1980-08-22'),
  ('Dona Geralda', 'F', '1950-03-15');

-- Verificando dados inseridos:
SELECT * FROM CLIENTE;

-- TABELA: PLANO
CREATE TABLE PLANO (
    idPlano SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    perc_cliente NUMERIC(5,2)
);

-- Exemplos:
INSERT INTO PLANO (nome, perc_cliente) VALUES ('Plano Ouro', 30.0), ('Plano Prata', 50.0);

-- Verificando dados inseridos:
SELECT * FROM PLANO;

-- TABELA: VALOR_US
CREATE TABLE VALOR_US (
    idPlano INTEGER REFERENCES PLANO(idPlano),
    data_inicial_vigencia DATE,
    data_final_vigencia DATE,
    valor NUMERIC(10,2),
    PRIMARY KEY (idPlano, data_inicial_vigencia)
);

-- Exemplos:
INSERT INTO VALOR_US (idPlano, data_inicial_vigencia, data_final_vigencia, valor)
VALUES 
  (1, '2024-01-01', '2026-12-31', 1.25),
  (2, '2024-01-01', '2026-12-31', 1.10);

-- Verificando dados inseridos:
SELECT * FROM VALOR_US;

-- TABELA: FATURA
CREATE TABLE FATURA (
    nr_fatura SERIAL PRIMARY KEY,
    idPlano INTEGER REFERENCES PLANO(idPlano),
    data_geracao DATE,
    data_envio DATE,
    data_pagamento DATE
);

-- Sem inserção inicial. Quando usar: via procedure FECHAR_FATURA_MES.

-- TABELA: EXAME_AUTORIZADO
CREATE TABLE EXAME_AUTORIZADO (
    idPlano INTEGER REFERENCES PLANO(idPlano),
    idExame INTEGER REFERENCES EXAME(idExame),
    valor_ch NUMERIC(10,2),
    PRIMARY KEY (idPlano, idExame)
);

-- Exemplos:
INSERT INTO EXAME_AUTORIZADO (idPlano, idExame, valor_ch)
VALUES 
  (1, 1, 10.0),
  (1, 2, 15.0),
  (2, 1, 12.0),
  (2, 3, 20.0);

-- Verificando dados inseridos:
SELECT * FROM EXAME_AUTORIZADO;

-- 🧩 Parte 2 – Particionamento de PEDIDO por RANGE de data_pedido
CREATE TABLE PEDIDO (
    nrPedido INTEGER,
    data_pedido DATE NOT NULL,
    idMedico INTEGER REFERENCES MEDICO(idMedico),
    idCliente INTEGER REFERENCES CLIENTE(idCliente),
    idPlano INTEGER NOT NULL REFERENCES PLANO(idPlano),
    UNIQUE (nrPedido, data_pedido)  -- Necessário para a FK da EXAME_PEDIDO
) PARTITION BY RANGE (data_pedido);

-- Criação das partições de PEDIDO
CREATE TABLE PEDIDO_2023 PARTITION OF PEDIDO
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE PEDIDO_2024 PARTITION OF PEDIDO
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE PEDIDO_2025 PARTITION OF PEDIDO
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- 🧪 Verificação:
-- Verifica estrutura das partições
SELECT inhrelid::regclass AS particao
FROM pg_inherits
WHERE inhparent = 'pedido'::regclass;

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
    FOREIGN KEY (nrPedido, data_pedido) REFERENCES PEDIDO(nrPedido, data_pedido)
) PARTITION BY RANGE (data_prevista);

-- Criação das partições de EXAME_PEDIDO
CREATE TABLE EXAME_PEDIDO_2023 PARTITION OF EXAME_PEDIDO
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE EXAME_PEDIDO_2024 PARTITION OF EXAME_PEDIDO
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE EXAME_PEDIDO_2025 PARTITION OF EXAME_PEDIDO
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- 🧪 Verificação:
-- Verifica estrutura das partições
SELECT inhrelid::regclass AS particao
FROM pg_inherits
WHERE inhparent = 'exame_pedido'::regclass;


-- 🔍 Parte 3 – Índices

CREATE INDEX idx_exame_material ON EXAME(idMaterial);
CREATE INDEX idx_valor_ls_periodo ON VALOR_US(data_inicial_vigencia, data_final_vigencia);
CREATE INDEX idx_examepedido_data ON EXAME_PEDIDO(data_prevista);
CREATE INDEX idx_pedido_cliente ON PEDIDO(idCliente);
CREATE INDEX idx_pedido_data ON PEDIDO(data_pedido);

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

-- 🧪 Exemplo:
-- Consulta o valor total pago por clientes em abril de 2024
SELECT CALCULA_VALOR_EXAMES_CLIENTES(4, 2024) AS valor_pago_clientes;

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

    -- Geração de nrPedido via sequence
    SELECT nextval('seq_nrPedido') INTO novo_pedido;

    -- Inserção na tabela particionada
    INSERT INTO PEDIDO (nrPedido, data_pedido, idMedico, idCliente, idPlano)
    VALUES (novo_pedido, CURRENT_DATE, p_idMedico, p_idCliente, p_idPlano);

    RETURN novo_pedido;
END;
$$ LANGUAGE plpgsql;

-- 🧪 Exemplo:
-- Cria um pedido para Ana Paula (cliente 1), Dr. João (médico 1), Plano Ouro (plano 1)
-- Suponha que retorne: 1
SELECT INSERE_PEDIDO(1, 1, 1);

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
    v_valor_ch NUMERIC;
BEGIN
    SELECT idPlano INTO id_plano
    FROM PEDIDO
    WHERE nrPedido = p_nrPedido AND data_pedido = p_dataPedido;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Pedido não encontrado';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM EXAME WHERE idExame = p_idExame) THEN
        RAISE EXCEPTION 'Exame não encontrado';
    END IF;

    SELECT valor_ch INTO v_valor_ch
    FROM EXAME_AUTORIZADO
    WHERE idPlano = id_plano AND idExame = p_idExame;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Exame não autorizado para este plano';
    END IF;

    SELECT valor INTO valor_us
    FROM VALOR_US
    WHERE idPlano = id_plano
      AND CURRENT_DATE BETWEEN data_inicial_vigencia AND data_final_vigencia
    LIMIT 1;

    IF valor_us IS NULL THEN
        RAISE EXCEPTION 'Valor US não encontrado para o plano na data atual';
    END IF;

    INSERT INTO EXAME_PEDIDO (
        nrPedido, data_pedido, idExame, data_prevista, valor
    ) VALUES (
        p_nrPedido, p_dataPedido, p_idExame, CURRENT_DATE, v_valor_ch * valor_us
    );
END;
$$;

-- 🧪 Exemplo:
-- Insere Hemograma (exame 1) para o pedido de Ana Paula (pedido 1)
CALL INSERE_EXAME_PEDIDO(1, CURRENT_DATE, 1);


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

-- 🧪 Exemplo:
-- Criando pedido para Carlos Eduardo (cliente 2), Dr. João (1), Plano Ouro (1)
SELECT INSERE_PEDIDO(1, 2, 1);  -- Suponha que retorne: 2
-- Tentando inserir Beta-HCG (2) — deverá falhar
CALL INSERE_EXAME_PEDIDO(2, CURRENT_DATE, 2);


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

-- 🧪 Exemplo:
-- Criando pedido para Dona Geralda (cliente 3), Dr. João (1), Plano Ouro (1)
SELECT INSERE_PEDIDO(1, 3, 1);  -- Suponha que retorne: 3
-- Tentando inserir Beta-HCG (2) — deverá falhar
CALL INSERE_EXAME_PEDIDO(3, CURRENT_DATE, 2);


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

-- 🧪 Exemplo:
-- Tentando inserir PSA (exame 3) para Ana Paula (cliente 1) — deverá falhar
CALL INSERE_EXAME_PEDIDO(1, CURRENT_DATE, 3);


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
    INSERT INTO FATURA (idPlano, data_geracao)
    VALUES (p_idPlano, CURRENT_DATE)
    RETURNING nr_fatura INTO nova_fatura_id;

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

-- 🧪 Exemplo:
-- Fecha a fatura do mês de abril de 2024 para o Plano Ouro (idPlano = 1)
CALL FECHAR_FATURA_MES(4, 2024, 1);

SELECT INSERE_PEDIDO(1, 1, 1);
CALL INSERE_EXAME_PEDIDO(1, CURRENT_DATE, 1); -- Hemograma

-- Consultando exames que foram faturados
CALL FECHAR_FATURA_MES(4, 2024, 1);
SELECT * FROM EXAME_PEDIDO WHERE nr_fatura IS NOT NULL;
