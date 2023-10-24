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

ALTER TABLE ambulatorio.faturamento
ADD COLUMN data_pagto DATE NOT NULL;

INSERT INTO ambulatorio.convenios (nome_conv, data_fatura)
VALUES ('Convênio A', '2023-09-22');

INSERT INTO ambulatorio.associados (nome_assoc, cidade, coordenadas, cod_conv)
VALUES ('Associado 1', 'Cidade 1', 'Coordenadas 1', 1);

INSERT INTO ambulatorio.faturamento (data_fatura, cod_conv, cod_assoc, data_venc, data_pagto)
VALUES ('2023-09-22', 1, 1, '2023-09-30', '2023-09-25');


-- Atividades 9 a 12

ALTER TABLE ambulatorio.faturamento
ADD CONSTRAINT check_data_pagto CHECK (data_pagto >= data_fatura AND data_pagto <= CURRENT_DATE);

INSERT INTO ambulatorio.faturamento (data_fatura, cod_conv, cod_assoc, data_venc, data_pagto)
VALUES ('2023-09-22', 1, 1, '2023-09-30', '2023-09-25');

INSERT INTO ambulatorio.faturamento (data_fatura, cod_conv, cod_assoc, data_venc, data_pagto)
VALUES ('2023-09-22', 1, 1, '2023-10-15', '2023-10-10');

SELECT a.nome_assoc, c.nome_conv
FROM ambulatorio.faturamento AS f
JOIN ambulatorio.associados AS a ON f.cod_assoc = a.cod_assoc
JOIN ambulatorio.convenios AS c ON f.cod_conv = c.cod_conv
WHERE f.data_pagto IS NULL;

ALTER TABLE ambulatorio.medicos
ADD COLUMN cod_conv INTEGER;

INSERT INTO ambulatorio.medicos (nome_medico, especialidade, cod_conv)
VALUES ('Médico 1', 'Cardiologista', 1);

INSERT INTO ambulatorio.medicos (nome_medico, especialidade, cod_conv)
VALUES ('Médico 2', 'Ortopedista', 2);

-- Atividade 1

-- 1.1: Visão de Atendimentos por Especialidade
CREATE OR REPLACE VIEW ambulatorio.atendimentos_por_especialidade AS
SELECT m.especialidade, COUNT(f.data_fatura) AS total_atendimentos
FROM ambulatorio.faturamento AS f
JOIN ambulatorio.medicos AS m ON f.cod_medico = m.cod_medico
GROUP BY m.especialidade;

-- 1.2: Visão de Atendimentos por Ambulatório Consolidando por Data
CREATE OR REPLACE VIEW ambulatorio.atendimentos_por_data AS
SELECT f.data_fatura, COUNT(f.data_fatura) AS total_atendimentos
FROM ambulatorio.faturamento AS f
GROUP BY f.data_fatura
ORDER BY f.data_fatura DESC;

-- 1.3: Tabela "no_show" para Consultas Canceladas
CREATE TABLE IF NOT EXISTS ambulatorio.no_show (
    cod_no_show SERIAL PRIMARY KEY,
    cod_faturamento INTEGER,
    data_cancelamento DATE
);

-- 1.4: Tabela de Auditoria para Alterações na Tabela de Pacientes
CREATE TABLE IF NOT EXISTS ambulatorio.auditoria_pacientes (
    cod_auditoria SERIAL PRIMARY KEY,
    acao VARCHAR(50),
    cod_paciente INTEGER,
    data_modificacao TIMESTAMP
);

-- Atividade 2
CREATE OR REPLACE FUNCTION registrar_no_show()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO ambulatorio.no_show (cod_faturamento, data_cancelamento)
    VALUES (OLD.cod_faturamento, CURRENT_DATE);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER consulta_cancelada
AFTER DELETE ON ambulatorio.faturamento
FOR EACH ROW
EXECUTE FUNCTION registrar_no_show();

-- Parte 3 e 4.

CREATE OR REPLACE FUNCTION auditar_pacientes()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO ambulatorio.auditoria_pacientes (acao, cod_paciente, data_modificacao)
        VALUES ('INSERT', NEW.cod_paciente, NOW());
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO ambulatorio.auditoria_pacientes (acao, cod_paciente, data_modificacao)
        VALUES ('UPDATE', NEW.cod_paciente, NOW());
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO ambulatorio.auditoria_pacientes (acao, cod_paciente, data_modificacao)
        VALUES ('DELETE', OLD.cod_paciente, NOW());
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER auditoria_pacientes
AFTER INSERT OR UPDATE OR DELETE ON ambulatorio.pacientes
FOR EACH ROW
EXECUTE FUNCTION auditar_pacientes();

