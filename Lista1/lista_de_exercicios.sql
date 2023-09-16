-- Criando Tabelas - EXERCICIO SLIDE 47

CREATE TABLE Ambulatorio (
    Num_a SERIAL PRIMARY KEY,
    Andar INT,
    Capacidade INT
);

CREATE TABLE Paciente (
    Cod_p SERIAL PRIMARY KEY,
    Nome VARCHAR(255),
    Idade INT,
    Cidade VARCHAR(255)
);

CREATE TABLE Medico (
    Cod_m SERIAL PRIMARY KEY,
    Nome VARCHAR(255),
    Idade INT,
    Espec VARCHAR(255),
    Cidade VARCHAR(255),
    Num_a INT REFERENCES Ambulatorio(Num_a)
);

CREATE TABLE Consulta (
    Cod_m INT REFERENCES Medico(Cod_m),
    Cod_p INT REFERENCES Paciente(Cod_p),
    Data DATE,
    Hora TIME
);

SELECT * FROM Medico
SELECT * FROM Paciente
SELECT * FROM Consulta
SELECT * FROM Ambulatorio

-- Preenchendo Tabelas - EXERCICIO SLIDE 48, 49, 50, 51

INSERT INTO Ambulatorio (Num_a, Andar, Capacidade)
VALUES
    (1, 1, 30),
    (2, 1, 50),
    (3, 2, 40),
    (4, 2, 25),
    (5, 2, 55),
    (6, 2, 10),
    (7, 2, 10);
	
SELECT * FROM Ambulatorio


INSERT INTO Medico (Cod_m, Nome, Idade, Espec, Cidade, Num_a)
VALUES
    (1, 'Joao', 40, 'ortopedista', 'Florianopolis', 1),
    (2, 'Maria', 42, 'oftalmologista', 'Blumenau', 2),
    (3, 'Pedro', 51, 'pediatra', 'Sao Jose', 2),
    (4, 'Carlos', 28, 'ortopedista', 'Florianopolis', 4),
    (5, 'Marcia', 33, 'neurologista', 'Florianopolis', 3),
    (6, 'Pedrinho', 38, 'infectologista', 'Blumenau', 1),
    (7, 'Mariana', 39, 'infectologista', 'Florianopolis', NULL),
    (8, 'Roberta', 50, 'neurologista', 'Joinville', 5),
    (9, 'Vanusa', 39, 'aa', 'Curitiba', NULL),
    (10, 'Valdo', 50, 'aa', 'Curitiba', NULL);
	
SELECT * FROM Medico

INSERT INTO Paciente (Cod_p, Nome, Idade, Cidade)
VALUES
    (1, 'Clevi', 60, 'Florianopolis'),
    (2, 'Cleusa', 25, 'Palhoca'),
    (3, 'Alberto', 45, 'Palhoca'),
    (4, 'Roberta', 44, 'Sao Jose'),
    (5, 'Fernanda', 3, 'Sao Jose'),
    (6, 'Luanda', 2, 'Florianopolis'),
    (7, 'Manuela', 69, 'Florianopolis'),
    (8, 'Caio', 45, 'Florianopolis'),
    (9, 'Andre', 83, 'Florianopolis'),
    (10, 'Andre', 21, 'Florianopolis');
	
SELECT * FROM Paciente

INSERT INTO Consulta (Cod_m, Cod_p, Data, Hora)
VALUES
    (1, 3, '2000-06-12', '14:00'),
    (4, 3, '2000-06-13', '9:00'),
    (2, 9, '2000-06-14', '14:00'),
    (7, 5, '2000-06-12', '10:00'),
    (8, 6, '2000-06-19', '13:00'),
    (5, 1, '2000-06-20', '13:00'),
    (6, 8, '2000-06-20', '20:30'),
    (6, 2, '2000-06-15', '11:00'),
    (6, 4, '2000-06-15', '14:00'),
    (7, 2, '2000-06-10', '19:30');

SELECT * FROM Consulta

-- EXERCICIO SLIDE 52
-- 1 
SELECT * FROM Medico WHERE Cidade = 'Florianopolis';

-- 2
SELECT Cod_m FROM Medico WHERE Nome = 'Roberta';

-- 3
SELECT DISTINCT Espec
FROM Medico
WHERE Cidade = 'Florianopolis';

-- 4
SELECT Consulta.Data
FROM Consulta
INNER JOIN Paciente ON Consulta.Cod_p = Paciente.Cod_p
WHERE Paciente.Nome = 'Caio';

-- 5
SELECT DISTINCT Paciente.Nome
FROM Consulta
INNER JOIN Medico ON Consulta.Cod_m = Medico.Cod_m
INNER JOIN Paciente ON Consulta.Cod_p = Paciente.Cod_p
WHERE Medico.Nome = 'Pedrinho';

-- 6
SELECT Medico.Nome AS Nome_Medico, Consulta.Data
FROM Medico
INNER JOIN Consulta ON Medico.Cod_m = Consulta.Cod_m;

-- 7
SELECT Medico.Nome AS Nome_Medico, Ambulatorio.Andar
FROM Medico
INNER JOIN Ambulatorio ON Medico.Num_a = Ambulatorio.Num_a
WHERE Medico.Espec = 'infectologista';

--8
SELECT Paciente.Nome AS Nome_Paciente
FROM Paciente
INNER JOIN Consulta ON Paciente.Cod_p = Consulta.Cod_p
INNER JOIN Medico ON Consulta.Cod_m = Medico.Cod_m
WHERE Medico.Num_a = 2;

-- 9
SELECT Paciente.Nome AS Nome_Paciente
FROM Paciente
INNER JOIN Consulta ON Paciente.Cod_p = Consulta.Cod_p
INNER JOIN Medico ON Consulta.Cod_m = Medico.Cod_m
WHERE Medico.Num_a = 2;

-- 10
SELECT Medico.Nome AS Nome_Medico, COALESCE(Paciente.Nome, 'null') AS Nome_Paciente
FROM Medico
LEFT JOIN Consulta ON Medico.Cod_m = Consulta.Cod_m
LEFT JOIN Paciente ON Consulta.Cod_p = Paciente.Cod_p;

-- 11
SELECT Paciente.Nome AS Nome_Paciente, Consulta.Data, Consulta.Hora
FROM Consulta
LEFT JOIN Paciente ON Consulta.Cod_p = Paciente.Cod_p
ORDER BY Paciente.Nome ASC, Consulta.Data DESC, Consulta.Hora DESC;

