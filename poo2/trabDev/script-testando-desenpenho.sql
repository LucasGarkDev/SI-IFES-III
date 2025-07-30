-- 1. FAZENDAS (mantido, já utiliza CEP real correspondente)
DO $$
DECLARE
    cidades TEXT[] := ARRAY[
        'São Paulo - SP', 'Rio de Janeiro - RJ', 'Belo Horizonte - MG', 'Porto Alegre - RS',
        'Curitiba - PR', 'Salvador - BA', 'Fortaleza - CE', 'Recife - PE', 'Manaus - AM', 'Belém - PA',
        'Florianópolis - SC', 'Goiânia - GO', 'Campo Grande - MS', 'Cuiabá - MT', 'Vitória - ES',
        'João Pessoa - PB', 'Maceió - AL', 'Natal - RN', 'São Luís - MA', 'Teresina - PI',
        'Aracaju - SE', 'Palmas - TO', 'Macapá - AP', 'Rio Branco - AC', 'Porto Velho - RO',
        'Brasília - DF', 'Santos - SP', 'Campinas - SP', 'Uberlândia - MG', 'Sorocaba - SP',
        'Niterói - RJ', 'Joinville - SC', 'Londrina - PR', 'Ribeirão Preto - SP', 'Juiz de Fora - MG',
        'Maringá - PR', 'São José dos Campos - SP', 'Caxias do Sul - RS', 'Anápolis - GO', 'Pelotas - RS',
        'Feira de Santana - BA', 'Blumenau - SC', 'Vila Velha - ES', 'Jundiaí - SP', 'Caruaru - PE',
        'Franca - SP', 'Itabuna - BA', 'Petrolina - PE', 'Ilhéus - BA', 'Teófilo Otoni - MG'
    ];
    ceps TEXT[] := ARRAY[
        '01000-000', '20000-000', '30000-000', '90000-000',
        '80000-000', '40000-000', '60000-000', '50000-000', '69000-000', '66000-000',
        '88000-000', '74000-000', '79000-000', '78000-000', '29000-000',
        '58000-000', '57000-000', '59000-000', '65000-000', '64000-000',
        '49000-000', '77000-000', '68900-000', '69900-000', '76800-000',
        '70000-000', '11000-000', '13000-000', '38400-000', '18000-000',
        '24000-000', '89200-000', '86000-000', '14000-000', '36000-000',
        '87000-000', '12200-000', '95000-000', '75000-000', '96000-000',
        '44000-000', '89000-000', '29100-000', '13200-000', '55000-000',
        '14400-000', '45600-000', '56300-000', '45650-000', '39800-000'
    ];
BEGIN
    FOR i IN 1..array_length(cidades, 1) LOOP
        INSERT INTO fazenda (
            nome, localizacao, tamanho_hectares, capacidade_bovinos, observacoes, cep
        ) VALUES (
            CONCAT('Fazenda ', i),
            cidades[i],
            500 + (random() * 1500)::int,
            50 + (random() * 150)::int,
            'Fazenda gerada para testes',
            ceps[i]
        );
    END LOOP;
END $$;


-- 2. BOVINOS (sem alteração necessária)
DO $$
DECLARE
    raca_ids INTEGER[];
    fazenda_ids INTEGER[];
    raca_id INTEGER;
    fazenda_id INTEGER;
    status_list TEXT[] := ARRAY['Comprado', 'Ativo', 'Vendido'];
BEGIN
    SELECT array_agg(idraca) INTO raca_ids FROM raca;
    SELECT array_agg(idfazenda) INTO fazenda_ids FROM fazenda;

    FOR i IN 1..10000 LOOP
        raca_id := raca_ids[1 + floor(random() * array_length(raca_ids, 1))];
        fazenda_id := fazenda_ids[1 + floor(random() * array_length(fazenda_ids, 1))];

        INSERT INTO bovino (origem, data_nascimento, peso_atual, status, raca_id, fazenda_id)
        VALUES (
            CONCAT('Bovino_', i),
            CURRENT_DATE - (365 * (1 + floor(random() * 5)))::int,
            200 + random() * 400,
            status_list[1 + floor(random() * array_length(status_list, 1))],
            raca_id,
            fazenda_id
        );
    END LOOP;
END $$;


-- 3. APLICAÇÃO DE VACINAS (mantido)
DO $$
DECLARE
    vacina_ids INTEGER[] := ARRAY[1, 2, 3, 4, 5];  
    bovino_id INTEGER;
    vac_id INTEGER;
    j INTEGER;
BEGIN
    FOR bovino_id IN SELECT idbovino FROM bovino LOOP
        FOR j IN 1..(1 + floor(random() * 3)::int) LOOP
            vac_id := vacina_ids[1 + floor(random() * array_length(vacina_ids, 1))];
            BEGIN
                INSERT INTO aplicacao_vacina (bovino_id, vacina_id, dataaplicacao)
                VALUES (
                    bovino_id,
                    vac_id,
                    CURRENT_DATE - (30 + floor(random() * 365))::int
                );
            EXCEPTION WHEN unique_violation THEN
                CONTINUE;
            END;
        END LOOP;
    END LOOP;
END $$;


-- 4. MOVIMENTAÇÕES (VERSÃO À PROVA DE ERRO)
DO $$
DECLARE
    tipo_list TEXT[] := ARRAY['Entrada', 'Saida', 'Transferencia'];
    motivo_entrada TEXT[] := ARRAY['Compra', 'Transferência'];
    motivo_saida TEXT[] := ARRAY['Venda', 'Abate', 'Transferência'];
    motivo_transferencia TEXT[] := ARRAY['Transferência'];

    bovino_ids INTEGER[];
    fazenda_ids INTEGER[];
    bovino_id INTEGER;
    origem_id INTEGER;
    destino_id INTEGER;
    tipo_mov TEXT;
    motivo_mov TEXT;
    valido BOOLEAN;
BEGIN
    SELECT array_agg(idbovino) INTO bovino_ids FROM bovino;
    SELECT array_agg(idfazenda) INTO fazenda_ids FROM fazenda;

    FOR i IN 1..5000 LOOP
        bovino_id := bovino_ids[1 + floor(random() * array_length(bovino_ids, 1))::int];
        origem_id := fazenda_ids[1 + floor(random() * array_length(fazenda_ids, 1))::int];

        LOOP
            destino_id := fazenda_ids[1 + floor(random() * array_length(fazenda_ids, 1))::int];
            EXIT WHEN destino_id != origem_id;
        END LOOP;

        valido := FALSE;
        -- Repete até gerar uma combinação válida
        WHILE NOT valido LOOP
            tipo_mov := tipo_list[1 + floor(random() * array_length(tipo_list, 1))::int];

            IF tipo_mov = 'Entrada' THEN
                motivo_mov := motivo_entrada[1 + floor(random() * array_length(motivo_entrada, 1))::int];
                -- Não permite motivo 'Venda' ou 'Abate'
                IF motivo_mov IN ('Venda', 'Abate') THEN
                    CONTINUE;
                END IF;
                valido := TRUE;
            ELSIF tipo_mov = 'Saida' THEN
                motivo_mov := motivo_saida[1 + floor(random() * array_length(motivo_saida, 1))::int];
                -- NÃO permite motivo 'Compra'
                IF motivo_mov = 'Compra' THEN
                    CONTINUE;
                END IF;
                valido := TRUE;
            ELSE -- Transferencia
                motivo_mov := 'Transferência';
                valido := TRUE;
            END IF;
        END LOOP;

        INSERT INTO movimentacao (
            tipo,
            data_movimentacao,
            motivo,
            observacoes,
            bovino_id,
            fazenda_origem_id,
            fazenda_destino_id
        )
        VALUES (
            tipo_mov,
            CURRENT_DATE - floor(random() * 730)::int, -- até 2 anos atrás
            motivo_mov,
            'Movimentação simulada para testes',
            bovino_id,
            origem_id,
            destino_id
        );
    END LOOP;
END $$;

-- Verificar as movimentações proibidas antes de apagar
SELECT * FROM movimentacao
WHERE (tipo = 'Saida' AND motivo = 'Compra')
   OR (tipo = 'Entrada' AND motivo IN ('Abate', 'Venda'));

