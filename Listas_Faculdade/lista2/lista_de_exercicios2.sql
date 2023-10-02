-- Atividades 1 a 4

CREATE SCHEMA IF NOT EXISTS ambulatorio;

CREATE TABLE IF NOT EXISTS ambulatorio.convenios (
    cod_conv SERIAL PRIMARY KEY,
    nome_conv VARCHAR(255) NOT NULL,
    data_fatura DATE
);

CREATE TABLE IF NOT EXISTS ambulatorio.associados (
    cod_assoc SERIAL PRIMARY KEY,
    nome_assoc VARCHAR(255) NOT NULL,
    cidade VARCHAR(255),
    coordenadas VARCHAR(255),
    cod_conv INTEGER REFERENCES ambulatorio.convenios(cod_conv)
);

CREATE TABLE IF NOT EXISTS ambulatorio.faturamento (
    data_fatura DATE,
    cod_conv INTEGER REFERENCES ambulatorio.convenios(cod_conv),
    cod_assoc INTEGER REFERENCES ambulatorio.associados(cod_assoc),
    data_venc DATE
);

-- Atividades 5 a 8

-- Adiciona a coluna 'data_pagto' na tabela 'faturamento' com restrição NOT NULL
ALTER TABLE ambulatorio.faturamento
ADD COLUMN data_pagto DATE NOT NULL;

-- Insere um registro na tabela 'convenios'
INSERT INTO ambulatorio.convenios (nome_conv, data_fatura)
VALUES ('Convênio A', '2023-09-22');

-- Insere um registro na tabela 'associados' com um convênio existente
INSERT INTO ambulatorio.associados (nome_assoc, cidade, coordenadas, cod_conv)
VALUES ('Associado 1', 'Cidade 1', 'Coordenadas 1', 1);

-- Insere um registro na tabela 'faturamento' com datas válidas
INSERT INTO ambulatorio.faturamento (data_fatura, cod_conv, cod_assoc, data_venc, data_pagto)
VALUES ('2023-09-22', 1, 1, '2023-09-30', '2023-09-25');

-- Tente inserir um registro na tabela 'faturamento' com convênio inexistente
-- Isso deve falhar devido à restrição de chave estrangeira
-- INSERT INTO ambulatorio.faturamento (data_fatura, cod_conv, cod_assoc, data_venc, data_pagto)
-- VALUES ('2023-09-22', 2, 1, '2023-09-30', '2023-09-25');

-- Tente inserir um registro na tabela 'faturamento' com associado inexistente
-- Isso deve falhar devido à restrição de chave estrangeira
-- INSERT INTO ambulatorio.faturamento (data_fatura, cod_conv, cod_assoc, data_venc, data_pagto)
-- VALUES ('2023-09-22', 1, 2, '2023-09-30', '2023-09-25');

-- Tente inserir um registro na tabela 'faturamento' com data de faturamento futura
-- Isso deve falhar devido à restrição CHECK
-- INSERT INTO ambulatorio.faturamento (data_fatura, cod_conv, cod_assoc, data_venc, data_pagto)
-- VALUES ('2023-09-25', 1, 1, '2023-09-30', '2023-09-25');

-- Tente inserir um registro na tabela 'faturamento' com data de vencimento anterior à atual
-- Isso deve falhar devido à restrição CHECK
-- INSERT INTO ambulatorio.faturamento (data_fatura, cod_conv, cod_assoc, data_venc, data_pagto)
-- VALUES ('2023-09-22', 1, 1, '2023-09-20', '2023-09-25');

-- Atividades 9 a 12

-- Adicione uma restrição para a data de pagamento na tabela de faturamento
ALTER TABLE ambulatorio.faturamento
ADD CONSTRAINT check_data_pagto CHECK (data_pagto >= data_fatura AND data_pagto <= CURRENT_DATE);

-- Insira datas de pagamento aleatórias
-- Certifique-se de que essas datas estejam dentro das restrições estabelecidas
-- Note que estamos usando a função CURRENT_DATE para obter a data atual
INSERT INTO ambulatorio.faturamento (data_fatura, cod_conv, cod_assoc, data_venc, data_pagto)
VALUES ('2023-09-22', 1, 1, '2023-09-30', '2023-09-25');

INSERT INTO ambulatorio.faturamento (data_fatura, cod_conv, cod_assoc, data_venc, data_pagto)
VALUES ('2023-09-22', 1, 1, '2023-10-15', '2023-10-10');

-- Tente inserir uma data de pagamento anterior à data de faturamento
-- Isso deve falhar devido à restrição CHECK
-- INSERT INTO ambulatorio.faturamento (data_fatura, cod_conv, cod_assoc, data_venc, data_pagto)
-- VALUES ('2023-09-22', 1, 1, '2023-09-30', '2023-09-20');

SELECT a.nome_assoc, c.nome_conv
FROM ambulatorio.faturamento AS f
JOIN ambulatorio.associados AS a ON f.cod_assoc = a.cod_assoc
JOIN ambulatorio.convenios AS c ON f.cod_conv = c.cod_conv
WHERE f.data_pagto IS NULL;

-- Adicione a coluna 'cod_conv' na tabela de médicos
ALTER TABLE ambulatorio.medicos
ADD COLUMN cod_conv INTEGER;

-- Insira dados de teste para médicos que aceitam vários convênios
INSERT INTO ambulatorio.medicos (nome_medico, especialidade, cod_conv)
VALUES ('Médico 1', 'Cardiologista', 1);

INSERT INTO ambulatorio.medicos (nome_medico, especialidade, cod_conv)
VALUES ('Médico 2', 'Ortopedista', 2);

-- Note que os valores de 'cod_conv' correspondem aos convênios existentes
-- Certifique-se de que os convênios correspondentes já existam na tabela 'convenios'
