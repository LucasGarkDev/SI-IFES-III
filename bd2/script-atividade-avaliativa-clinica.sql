-- 🧱 Parte 0 – Criação das Tabelas (DROP e CRIAÇÃO BASE)
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

-- 🧩 Parte 1 – Particionamento de PEDIDO por RANGE de data_pedido

-- TABELA MÃE: PEDIDO
CREATE TABLE PEDIDO (
    nrPedido INTEGER,
    data_pedido DATE NOT NULL,
    idMedico INTEGER REFERENCES MEDICO(idMedico),
    idCliente INTEGER REFERENCES CLIENTE(idCliente),
    idPlano INTEGER NOT NULL REFERENCES PLANO(idPlano),
    UNIQUE (nrPedido, data_pedido)
) PARTITION BY RANGE (data_pedido);

-- PARTIÇÃO: PEDIDO_2023
CREATE TABLE PEDIDO_2023 PARTITION OF PEDIDO
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

-- Inserindo valores em PEDIDO_2023
INSERT INTO PEDIDO (nrPedido, data_pedido, idMedico, idCliente, idPlano)
VALUES (101, '2023-04-15', 1, 1, 1);

-- Verificando valores inseridos
SELECT * FROM PEDIDO_2023;

-- PARTIÇÃO: PEDIDO_2024
CREATE TABLE PEDIDO_2024 PARTITION OF PEDIDO
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- Inserindo valores em PEDIDO_2024
INSERT INTO PEDIDO (nrPedido, data_pedido, idMedico, idCliente, idPlano)
VALUES (102, '2024-06-10', 1, 2, 1);

-- Verificando valores inseridos
SELECT * FROM PEDIDO_2024;

-- PARTIÇÃO: PEDIDO_2025
CREATE TABLE PEDIDO_2025 PARTITION OF PEDIDO
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Inserindo valores em PEDIDO_2025
INSERT INTO PEDIDO (nrPedido, data_pedido, idMedico, idCliente, idPlano)
VALUES (103, '2025-09-01', 1, 3, 2);

-- Verificando valores inseridos
SELECT * FROM PEDIDO_2025;

-- Verificação da estrutura geral das partições de PEDIDO
SELECT inhrelid::regclass AS particao
FROM pg_inherits
WHERE inhparent = 'pedido'::regclass;

-- =====================================================
-- TABELA MÃE: EXAME_PEDIDO (particionada por data_prevista)
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

-- PARTIÇÃO: EXAME_PEDIDO_2023
CREATE TABLE EXAME_PEDIDO_2023 PARTITION OF EXAME_PEDIDO
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

-- Inserindo valores em EXAME_PEDIDO_2023
INSERT INTO EXAME_PEDIDO (nrPedido, data_pedido, idExame, data_prevista, valor)
VALUES (101, '2023-04-15', 1, '2023-04-17', 25.00);

-- Verificando valores inseridos
SELECT * FROM EXAME_PEDIDO_2023;

-- PARTIÇÃO: EXAME_PEDIDO_2024
CREATE TABLE EXAME_PEDIDO_2024 PARTITION OF EXAME_PEDIDO
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- Inserindo valores em EXAME_PEDIDO_2024
INSERT INTO EXAME_PEDIDO (nrPedido, data_pedido, idExame, data_prevista, valor)
VALUES (102, '2024-06-10', 2, '2024-06-12', 45.00);

-- Verificando valores inseridos
SELECT * FROM EXAME_PEDIDO_2024;

-- PARTIÇÃO: EXAME_PEDIDO_2025
CREATE TABLE EXAME_PEDIDO_2025 PARTITION OF EXAME_PEDIDO
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Inserindo valores em EXAME_PEDIDO_2025
INSERT INTO EXAME_PEDIDO (nrPedido, data_pedido, idExame, data_prevista, valor)
VALUES (103, '2025-09-01', 3, '2025-09-02', 55.00);

-- Verificando valores inseridos
SELECT * FROM EXAME_PEDIDO_2025;

-- Verificação da estrutura geral das partições de EXAME_PEDIDO
SELECT inhrelid::regclass AS particao
FROM pg_inherits
WHERE inhparent = 'exame_pedido'::regclass;

-- 🔍 Parte 2 – Índices

CREATE INDEX idx_exame_material ON EXAME(idMaterial);
CREATE INDEX idx_valor_ls_periodo ON VALOR_US(data_inicial_vigencia, data_final_vigencia);
CREATE INDEX idx_examepedido_data ON EXAME_PEDIDO(data_prevista);

-- 🔎 [TESTE] Avaliação do índice em PEDIDO(idCliente)

-- 🔻 Passo 1 – Garantir que o índice ainda não existe
DROP INDEX IF EXISTS idx_pedido_cliente;

-- 🔻 Passo 2 – Consulta sem índice (vai forçar um Seq Scan)
EXPLAIN ANALYZE
SELECT *
FROM PEDIDO
WHERE idCliente = 1;

-- 🔻 Passo 3 – Criar o índice
CREATE INDEX idx_pedido_cliente ON PEDIDO(idCliente);

-- 🔻 Passo 4 – Consulta após criar o índice (espera-se Index Scan)
EXPLAIN ANALYZE
SELECT *
FROM PEDIDO
WHERE idCliente = 1;

CREATE INDEX idx_pedido_data ON PEDIDO(data_pedido);

-- 📝 Parte 3 – Função CALCULA_VALOR_EXAMES_CLIENTES

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
-- 🔄 Inserindo pedido pago pelo PLANO DE SAÚDE (não deve entrar no cálculo)
-- Ana Paula, plano 1, data em abril de 2024 (cai na partição PEDIDO_2024)
INSERT INTO PEDIDO (nrPedido, data_pedido, idMedico, idCliente, idPlano)
VALUES (201, '2024-04-15', 1, 1, 1);

-- Exame vinculado ao pedido 201, com valor
INSERT INTO EXAME_PEDIDO (nrPedido, data_pedido, idExame, data_prevista, valor, plano)
VALUES (201, '2024-04-15', 1, '2024-04-16', 100.00, 1);

-- 🔄 Inserindo pedido pago pelo CLIENTE (deve entrar no cálculo)
-- Carlos Eduardo, plano pago pelo próprio cliente, data em abril de 2024
INSERT INTO PEDIDO (nrPedido, data_pedido, idMedico, idCliente, idPlano)
VALUES (202, '2024-04-20', 1, 2, 2);

-- Exame vinculado ao pedido 202, valor pago diretamente (plano IS NULL)
INSERT INTO EXAME_PEDIDO (nrPedido, data_pedido, idExame, data_prevista, valor, plano)
VALUES (202, '2024-04-20', 2, '2024-04-21', 80.00, NULL);

-- 🔄 Outro exame pago por CLIENTE no mesmo mês
INSERT INTO EXAME_PEDIDO (nrPedido, data_pedido, idExame, data_prevista, valor, plano)
VALUES (202, '2024-04-20', 1, '2024-04-22', 120.00, NULL);

-- ✅ Consulta: valor total de exames pagos diretamente pelos clientes em abril de 2024
SELECT CALCULA_VALOR_EXAMES_CLIENTES(4, 2024) AS valor_pago_clientes;

-- 📝 Parte 4 – Função INSERE_PEDIDO
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
-- 🟢 CASO 1: INSERÇÃO CORRETA
-- Esperado: sucesso. Cria um novo pedido com IDs válidos.
-- Méd. João (1), Cliente Ana Paula (1), Plano Ouro (1)

SELECT INSERE_PEDIDO(1, 1, 1) AS resultado_ok;

-- 🔴 CASO 2: MÉDICO INEXISTENTE
-- Esperado: erro 'Médico não encontrado.'
-- Méd. 999 não existe, Cliente 1, Plano 1

SELECT INSERE_PEDIDO(999, 1, 1);

-- 🔴 CASO 3: CLIENTE INEXISTENTE
-- Esperado: erro 'Cliente não encontrado.'
-- Méd. 1, Cliente 999 não existe, Plano 1

SELECT INSERE_PEDIDO(1, 999, 1);

-- 🔴 CASO 4: PLANO INEXISTENTE
-- Esperado: erro 'Plano não encontrado.'
-- Méd. 1, Cliente 1, Plano 999 não existe

SELECT INSERE_PEDIDO(1, 1, 999);

-- 🟡 CASO 5: INSERÇÃO COM NOVO CLIENTE CADASTRADO NA HORA
-- Primeiro insere novo cliente e depois faz o pedido

INSERT INTO CLIENTE (nome, sexo, nascimento) VALUES ('Roberta Nunes', 'F', '1985-11-25');

-- Verifica o id gerado (digamos que foi 4)
SELECT idCliente FROM CLIENTE WHERE nome = 'Roberta Nunes';

-- Faz o pedido para essa nova cliente com dados válidos
SELECT INSERE_PEDIDO(1, 4, 1) AS resultado_roberta;

-- 🧮 Parte 5 – STORED PROCEDURE INSERE_EXAME_PEDIDO

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
    -- 1. Verifica se o pedido existe e obtém o plano associado
    SELECT idPlano INTO id_plano
    FROM PEDIDO
    WHERE nrPedido = p_nrPedido AND data_pedido = p_dataPedido;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Pedido não encontrado';
    END IF;

    -- 2. Verifica se o exame existe
    IF NOT EXISTS (SELECT 1 FROM EXAME WHERE idExame = p_idExame) THEN
        RAISE EXCEPTION 'Exame não encontrado';
    END IF;

    -- 3. Verifica se o exame é autorizado para o plano
    SELECT valor_ch INTO v_valor_ch
    FROM EXAME_AUTORIZADO
    WHERE idPlano = id_plano AND idExame = p_idExame;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Exame não autorizado para este plano';
    END IF;

    -- 4. Busca o valor US vigente com base na data do pedido (e não na data atual!)
    SELECT valor INTO valor_us
    FROM VALOR_US
    WHERE idPlano = id_plano
      AND p_dataPedido BETWEEN data_inicial_vigencia AND data_final_vigencia
    LIMIT 1;

    IF valor_us IS NULL THEN
        RAISE EXCEPTION 'Valor US não encontrado para o plano na data do pedido';
    END IF;

    -- 5. Insere o exame vinculado ao pedido com o valor calculado
    INSERT INTO EXAME_PEDIDO (
        nrPedido, data_pedido, idExame, data_prevista, valor
    ) VALUES (
        p_nrPedido, p_dataPedido, p_idExame, CURRENT_DATE, v_valor_ch * valor_us
    );
END;
$$;

-- 🧪 Exemplo:
-- ✅ Inserção válida
-- Pedido 101 (2023-04-15), Exame 1 (Hemograma), autorizado para plano 1
CALL INSERE_EXAME_PEDIDO(101, '2023-04-15', 1);

-- 🔎 Verifica se o exame foi inserido
SELECT * FROM EXAME_PEDIDO WHERE nrPedido = 101;

-- ❌ ERRO: Pedido inexistente
CALL INSERE_EXAME_PEDIDO(999, '2024-04-15', 1);
-- Esperado: 'Pedido não encontrado'

-- ❌ ERRO: Exame inexistente
CALL INSERE_EXAME_PEDIDO(101, '2023-04-15', 999);
-- Esperado: 'Exame não encontrado'

-- ❌ ERRO: Exame não autorizado para o plano do pedido
CALL INSERE_EXAME_PEDIDO(101, '2023-04-15', 3);
-- Esperado: 'Exame não autorizado para este plano'

-- ⚠️ Simula ausência de valor vigente no período
UPDATE VALOR_US
SET data_inicial_vigencia = '2025-01-01', data_final_vigencia = '2025-12-31'
WHERE idPlano = 1;

-- ❌ ERRO: Sem valor US vigente na data do pedido
CALL INSERE_EXAME_PEDIDO(101, '2023-04-15', 1);
-- Esperado: 'Valor US não encontrado para o plano na data do pedido'

-- 🔁 Corrige valor US para restaurar funcionamento normal
UPDATE VALOR_US
SET data_inicial_vigencia = '2024-01-01', data_final_vigencia = '2026-12-31'
WHERE idPlano = 1;

-- 🔎 Verificação final
SELECT * FROM EXAME_PEDIDO
ORDER BY data_prevista DESC;

-- 🛑 Parte 6 – RULE para impedir exame de gravidez (Beta-HCG) para homens

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

-- 🧪 Exemplo completo de teste

DO $$
DECLARE
    v_nrPedido INTEGER;
BEGIN
    -- 🔹 Passo 1: Cria o pedido para Carlos Eduardo (sexo M)
    v_nrPedido := INSERE_PEDIDO(1, 2, 1);  -- médico 1, cliente 2, plano 1
    RAISE NOTICE 'Pedido criado: %', v_nrPedido;

    -- 🔹 Passo 2: Tenta inserir Beta-HCG → Deve ser bloqueado silenciosamente
    BEGIN
        CALL INSERE_EXAME_PEDIDO(v_nrPedido, CURRENT_DATE, 2);  -- exame Beta-HCG
        RAISE NOTICE 'Inserção concluída (esperado: bloqueio pela RULE)';
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Erro inesperado: %', SQLERRM;
    END;

    -- 🔹 Passo 3: Verifica se o exame foi mesmo inserido
    PERFORM 1 FROM EXAME_PEDIDO ep
    JOIN EXAME e ON ep.idExame = e.idExame
    WHERE ep.nrPedido = v_nrPedido AND e.nome ILIKE '%beta-hcg%';

    IF FOUND THEN
        RAISE NOTICE '❌ ERRO: Exame Beta-HCG foi inserido (isso não deveria acontecer)';
    ELSE
        RAISE NOTICE '✅ SUCESSO: Exame Beta-HCG NÃO foi inserido (regra funcionou)';
    END IF;

END $$;


-- 🛑 Parte 7 – RULE para impedir gravidez para mulheres com 65 anos ou mais

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
-- 🧪 Teste da RULE impedir_gravidez_idosas
-- 👵 Cliente: Dona Geralda (idCliente = 3, sexo = 'F', nascimento = 1950)
-- 👨‍⚕️ Médico: Dr. João (idMedico = 1)
-- 🧾 Plano: Ouro (idPlano = 1)

DO $$
DECLARE
    v_nrPedido INTEGER;
BEGIN
    -- 🔹 Passo 1: Criar um pedido para Dona Geralda
    v_nrPedido := INSERE_PEDIDO(1, 3, 1);  -- médico 1, cliente 3, plano 1
    RAISE NOTICE 'Pedido criado para Dona Geralda: %', v_nrPedido;

    -- 🔹 Passo 2: Tentar inserir exame Beta-HCG (idExame = 2)
    BEGIN
        CALL INSERE_EXAME_PEDIDO(v_nrPedido, CURRENT_DATE, 2);
        RAISE NOTICE 'Inserção concluída (esperado: bloqueio pela RULE)';
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Erro inesperado: %', SQLERRM;
    END;

    -- 🔹 Passo 3: Verificar se exame Beta-HCG foi inserido
    PERFORM 1 FROM EXAME_PEDIDO ep
    JOIN EXAME e ON ep.idExame = e.idExame
    WHERE ep.nrPedido = v_nrPedido AND e.nome ILIKE '%beta-hcg%';

    IF FOUND THEN
        RAISE NOTICE '❌ ERRO: Beta-HCG foi inserido para idosa (isso não deveria ocorrer)';
    ELSE
        RAISE NOTICE '✅ SUCESSO: Beta-HCG NÃO foi inserido para idosa (regra funcionou)';
    END IF;

END $$;


-- 🛑 Parte 8 – RULE para impedir exame de próstata (PSA) para mulheres

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

-- 👤 Cliente: Ana Paula (idCliente = 1, sexo = 'F')
-- 🧑 Médico: Dr. João (idMedico = 1)
-- 📄 Plano: Ouro (idPlano = 1)
-- 🧪 Exame PSA (idExame = 3)

DO $$
DECLARE
    v_nrPedido INTEGER;
BEGIN
    -- Passo 1: Criar pedido válido para Ana Paula
    v_nrPedido := INSERE_PEDIDO(1, 1, 1);
    RAISE NOTICE 'Pedido criado para Ana Paula: %', v_nrPedido;

    -- Passo 2: Tentar inserir exame PSA → Deve ser BLOQUEADO pela RULE
    BEGIN
        CALL INSERE_EXAME_PEDIDO(v_nrPedido, CURRENT_DATE, 3);
        RAISE NOTICE '❌ ERRO: PSA foi inserido para mulher (isso não deveria ocorrer)';
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE '✅ Inserção bloqueada com sucesso pela RULE (como esperado)';
    END;

    -- Passo 3: Verificar se o exame PSA foi inserido mesmo assim
    PERFORM 1
    FROM EXAME_PEDIDO ep
    JOIN EXAME e ON ep.idExame = e.idExame
    WHERE ep.nrPedido = v_nrPedido AND e.nome ILIKE '%psa%';

    IF FOUND THEN
        RAISE NOTICE '❌ ERRO: Exame PSA foi inserido para mulher — isso não deveria ocorrer';
    ELSE
        RAISE NOTICE '✅ Exame PSA não foi inserido para mulher — comportamento correto';
    END IF;
END $$;



-- 🔄 Parte 9 – PROCEDURE FECHAR_FATURA_MES

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
-- ✅ CENÁRIO 1: Faturar exames do Plano Ouro (1) em abril de 2024
-- Deve atualizar exames sem fatura vinculados a esse plano e período

CALL FECHAR_FATURA_MES(4, 2024, 1);

-- Verifica os exames atualizados com fatura no período
SELECT ep.*, f.data_geracao
FROM EXAME_PEDIDO ep
JOIN FATURA f ON ep.nr_fatura = f.nr_fatura
WHERE EXTRACT(MONTH FROM ep.data_pedido) = 4
  AND EXTRACT(YEAR FROM ep.data_pedido) = 2024
  AND f.idPlano = 1;

-- 🔁 CENÁRIO 2: Repetir chamada — exames já faturados não devem ser afetados

CALL FECHAR_FATURA_MES(4, 2024, 1);

-- Resultado: nenhuma linha nova deve ser atualizada (já foram faturadas antes)

-- ❌ CENÁRIO 3: Tentar faturar mês onde não há exames realizados

CALL FECHAR_FATURA_MES(1, 2022, 1);  -- Esperado: cria a fatura mas não associa nenhum exame

-- Verifica se há exames associados
SELECT * FROM EXAME_PEDIDO WHERE nr_fatura IN (
    SELECT nr_fatura FROM FATURA WHERE EXTRACT(MONTH FROM data_geracao) = 1 AND EXTRACT(YEAR FROM data_geracao) = 2022
);

-- ✅ CENÁRIO 4: Visualizar todas as faturas e exames faturados
SELECT f.nr_fatura, f.idPlano, f.data_geracao, COUNT(ep.*) AS qtd_exames
FROM FATURA f
LEFT JOIN EXAME_PEDIDO ep ON f.nr_fatura = ep.nr_fatura
GROUP BY f.nr_fatura, f.idPlano, f.data_geracao
ORDER BY f.data_geracao DESC;

-- 🗑️ CENÁRIO 5: Verificar exames que ainda não foram faturados
SELECT * FROM EXAME_PEDIDO WHERE nr_fatura IS NULL;
