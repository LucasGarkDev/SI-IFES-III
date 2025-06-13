-- 1. FAZENDAS (usando 50 cidades reais do Brasil)
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
BEGIN
    FOR i IN 1..50 LOOP
        INSERT INTO fazenda (
            nome, localizacao, tamanho_hectares, capacidade_bovinos, observacoes, cep
        ) VALUES (
            CONCAT('Fazenda ', i),
            cidades[i],
            500 + (random() * 1500)::int,   -- tamanho entre 500 e 2000 hectares
            50 + (random() * 150)::int,     -- capacidade entre 50 e 200 bovinos
            'Fazenda gerada para testes',
            CONCAT('7500-', LPAD(i::text, 4, '0')) -- CEP simulado
        );
    END LOOP;
END $$;



-- 2. BOVINOS - COM ID VÁLIDO
DO $$
DECLARE
    raca_ids INTEGER[];
    fazenda_ids INTEGER[];
    raca_id INTEGER;
    fazenda_id INTEGER;
    status_list TEXT[] := ARRAY['Comprado', 'Ativo', 'Vendido'];
BEGIN
    -- Usa os nomes corretos das colunas de ID
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

-- 3. APLICAÇÃO DE VACINAS
-- (Seleciona até 3 vacinas aleatórias por bovino)
DO $$
DECLARE
    vacina_ids INTEGER[] := ARRAY[1, 2, 3, 4, 5];  -- IDs das vacinas
    bovino_id INTEGER;
    vac_id INTEGER;
    j INTEGER;
BEGIN
    FOR bovino_id IN SELECT idbovino FROM bovino LOOP
        -- Insere entre 1 a 3 vacinas para cada bovino
        FOR j IN 1..(1 + floor(random() * 3)::int) LOOP
            vac_id := vacina_ids[1 + floor(random() * array_length(vacina_ids, 1))];

            BEGIN
                INSERT INTO aplicacao_vacina (bovino_id, vacina_id, dataaplicacao, observacoes)
                VALUES (
                    bovino_id,
                    vac_id,
                    CURRENT_DATE - (30 + floor(random() * 365))::int,
                    'Aplicação teste'
                );
            EXCEPTION WHEN unique_violation THEN
                CONTINUE; -- Evita duplicação na PK composta
            END;
        END LOOP;
    END LOOP;
END $$;

-- 4. MOVIMENTAÇÕES (5.000)
DO $$
DECLARE
    tipo_list TEXT[] := ARRAY['Entrada', 'Saida', 'Transferencia'];
    motivo_list TEXT[] := ARRAY['Compra', 'Venda', 'Abate', 'Transferência'];

    bovino_ids INTEGER[];
    fazenda_ids INTEGER[];
    bovino_id INTEGER;
    origem_id INTEGER;
    destino_id INTEGER;
BEGIN
    -- Obtem os IDs reais
    SELECT array_agg(idbovino) INTO bovino_ids FROM bovino;
    SELECT array_agg(idfazenda) INTO fazenda_ids FROM fazenda;

    FOR i IN 1..5000 LOOP
        bovino_id := bovino_ids[1 + floor(random() * array_length(bovino_ids, 1))::int];

        -- Seleciona origem e destino diferentes
        origem_id := fazenda_ids[1 + floor(random() * array_length(fazenda_ids, 1))::int];
        LOOP
            destino_id := fazenda_ids[1 + floor(random() * array_length(fazenda_ids, 1))::int];
            EXIT WHEN destino_id != origem_id;
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
            tipo_list[1 + floor(random() * array_length(tipo_list, 1))::int],
            CURRENT_DATE - floor(random() * 730)::int, -- até 2 anos atrás
            motivo_list[1 + floor(random() * array_length(motivo_list, 1))::int],
            'Movimentação simulada para testes',
            bovino_id,
            origem_id,
            destino_id
        );
    END LOOP;
END $$;

