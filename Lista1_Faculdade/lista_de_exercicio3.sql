-- Exercicio 1
-- Tabela para dados pessoais dos funcionários
CREATE TABLE IF NOT EXISTS funcionario.dados (
    matricula SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data_de_nasc DATE,
    nacionalidade VARCHAR(255),
    sexo CHAR(1),
    estado_civil VARCHAR(20),
    rg VARCHAR(20) UNIQUE, 
    cic VARCHAR(14) UNIQUE, 
    endereco VARCHAR(255),
    telefone VARCHAR(20),
    data_de_admissao DATE
);

-- Tabela para histórico de cargos dos funcionários
CREATE TABLE IF NOT EXISTS funcionario.cargos (
    cargo_id SERIAL PRIMARY KEY,
    cargo VARCHAR(255) NOT NULL,
    matricula INT,
    dt_inicio DATE,
    dt_fim DATE,
    FOREIGN KEY (matricula) REFERENCES funcionario.dados(matricula)
);

-- Tabela para dependentes dos funcionários
CREATE TABLE IF NOT EXISTS funcionario.dependentes (
    dependente_id SERIAL PRIMARY KEY,
    matricula INT,
    nome VARCHAR(255) NOT NULL,
    dt_nascimento DATE,
    FOREIGN KEY (matricula) REFERENCES funcionario.dados(matricula)
);

-- Exercicio 2
CREATE SCHEMA IF NOT EXISTS paciente;

-- Tabela para dados pessoais dos pacientes
CREATE TABLE IF NOT EXISTS paciente.dados (
    numero_paciente SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data_de_nasc DATE,
    sexo CHAR(1),
    convenio VARCHAR(255),
    estado_civil VARCHAR(20),
    rg VARCHAR(20) UNIQUE, -- RG é único para cada paciente
    telefone VARCHAR(20),
    endereco VARCHAR(255)
);

-- Tabela para exames realizados
CREATE TABLE IF NOT EXISTS paciente.exames (
    exame_id SERIAL PRIMARY KEY,
    exame VARCHAR(255) NOT NULL
);

-- Tabela para consultas realizadas
CREATE TABLE IF NOT EXISTS paciente.consultas (
    numero_consulta SERIAL PRIMARY KEY,
    data DATE,
    medico_crm VARCHAR(10), -- Usar o CRM como chave, você pode ajustar o tamanho conforme necessário
    diagnostico TEXT,
    paciente_numero INT,
    exame_id INT,
    FOREIGN KEY (paciente_numero) REFERENCES paciente.dados(numero_paciente),
    FOREIGN KEY (exame_id) REFERENCES paciente.exames(exame_id)
);

-- Exercicio 3
-- Criação do esquema compra se não existir
CREATE SCHEMA IF NOT EXISTS compra;

-- Tabela para ordens de compra
CREATE TABLE IF NOT EXISTS compra.ordem (
    codigo_ordem_compra SERIAL PRIMARY KEY,
    data_emissao DATE,
    codigo_fornecedor INT,
    FOREIGN KEY (codigo_fornecedor) REFERENCES compra.fornecedor(codigo_fornecedor)
);

-- Tabela para fornecedores
CREATE TABLE IF NOT EXISTS compra.fornecedor (
    codigo_fornecedor SERIAL PRIMARY KEY,
    nome_fornecedor VARCHAR(255) NOT NULL,
    endereco_fornecedor VARCHAR(255)
);

-- Tabela para itens de compra
CREATE TABLE IF NOT EXISTS compra.itens (
    item_id SERIAL PRIMARY KEY,
    codigo_ordem_compra INT,
    descricao VARCHAR(255) NOT NULL,
    quantidade INT,
    valor_unitario NUMERIC(10, 2),
    valor_total_item NUMERIC(10, 2),
    FOREIGN KEY (codigo_ordem_compra) REFERENCES compra.ordem(codigo_ordem_compra)
);

-- Exercicio 4
-- Criação do esquema projetos se não existir
CREATE SCHEMA IF NOT EXISTS projetos;

-- Tabela para dados do projeto
CREATE TABLE IF NOT EXISTS projetos.dados (
    cod_projeto SERIAL PRIMARY KEY,
    data_inicio DATE,
    cod_departamento INT,
    cod_gerente INT,
    nome_projeto VARCHAR(255) NOT NULL,
    data_fim DATE,
    FOREIGN KEY (cod_departamento) REFERENCES projetos.departamentos(cod_departamento),
    FOREIGN KEY (cod_gerente) REFERENCES projetos.empregados(cod_empregado)
);

-- Tabela para departamentos
CREATE TABLE IF NOT EXISTS projetos.departamentos (
    cod_departamento SERIAL PRIMARY KEY,
    nome_departamento VARCHAR(255)
);

-- Tabela para empregados
CREATE TABLE IF NOT EXISTS projetos.empregados (
    cod_empregado SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    num_horas_trabalhadas INT,
    total_horas_trabalhadas INT
);
