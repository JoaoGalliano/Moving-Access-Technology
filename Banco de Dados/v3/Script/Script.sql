CREATE DATABASE MAT;
USE MAT;


-- Tabela Empresa:

CREATE TABLE Empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	cnpj VARCHAR(20)
);

INSERT INTO Empresa (nome, cnpj) VALUES 
-- id1:
('Estapar', '72423437000149'),
-- id2:
('MultiPark', '31985344000120'),
-- id3:
('Stop & Park', '57410487000106');


-- Tabela Estacionamento [relação n:1 com Empresa]:

CREATE TABLE Estacionamento (
	idEstacionamento INT PRIMARY KEY AUTO_INCREMENT,
	cep VARCHAR(20),
	endereco VARCHAR(120),
	-- bairro VARCHAR(40),
	-- cidade VARCHAR(35),
	-- estado CHAR(2),
	numVagas INT,
	fkEmpresa INT,
	FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa)
);

INSERT INTO Estacionamento (cep, endereco, numVagas, fkEmpresa) VALUES 
-- id1:
('01310916', 'Av. Paulista, 1374 - Bela Vista, São Paulo - SP', 600, 1),
-- id2:
('01046001', 'Av. São Luís, 112 - Republica, São Paulo - SP', 450, 1),
-- id3:
('01332000', 'R. Itapeva, 636 - Bela Vista, São Paulo - SP', 200, 2),
-- id4:
('01318000', 'Av. Brigadeiro Luís Antônio, 306 - Bela Vista, São Paulo - SP', 300, 2),
-- id5:
('01301000', 'R. da Consolação, 247 - Consolação, São Paulo - SP', 400, 3),
-- id6:
('01412000', 'R. Augusta, 1808 - Cerqueira César, São Paulo - SP', 250, 3);


-- Tabela Administrador [relação n:1 com Empresa]:

CREATE TABLE Administrador (
	idAdministrador INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	sobrenome VARCHAR(45),
	email VARCHAR(60),
	senha VARCHAR(45),
	fkEmpresa INT,
	fkAdmChefe INT,
	FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa),
	FOREIGN KEY (fkAdmChefe) REFERENCES Administrador (idAdministrador)
);

INSERT INTO Administrador (nome, sobrenome, email, senha, fkEmpresa, fkAdmChefe) VALUES
-- id1: 
('Karen', 'Albuquerque', 'Karen@estapar.com', 'IEX22dbI', 1, null),
-- id2: 
('Robert', 'Pereira', 'Robert@estapar.com', '5Switbxz', 1, 1),
-- id3: 
('Miguel', 'Ferrari', 'Miguel@multipark.com', 'ck5ZbpTZ', 2, null),
-- id4: 
('Monica', 'Costa', 'Monica@multipark.com', 'UKu7TF5d', 2, 3),
-- id5: 
('Alice', 'Nakamura', 'Alice@stoppark.com', 'JSWBxyKr', 3, null),
-- id6: 
('Pedro', 'Gomes', 'Pedro@stoppark.com', 'G6P1YDq1', 3, 5);


-- Tabela Administrador_Estacionamento [relação N:m Administrador_has_Estacionamento]:

CREATE TABLE Administrador_Estacionamento (
	fkAdministrador INT,
	fkEstacionamento INT,
	PRIMARY KEY (fkAdministrador, fkEstacionamento),
	FOREIGN KEY (fkAdministrador) REFERENCES Administrador (idAdministrador),
	FOREIGN KEY (fkEstacionamento) REFERENCES Estacionamento (idEstacionamento)
);

INSERT INTO Administrador_Estacionamento (fkAdministrador, fkEstacionamento) VALUES 
-- id1:
(1, 1),
-- id2:
(2, 2),
-- id3:
(3, 3),
-- id4:
(4, 4),
-- id5:
(5, 5),
-- id6:
(6, 6);


-- Tabela Sensor [relação n:1 com Estacionamento]:

CREATE TABLE Sensor (
	idSensor  INT PRIMARY KEY AUTO_INCREMENT,
	fkEstacionamento INT,
	fkEmpresa INT,
	FOREIGN KEY (fkEstacionamento) REFERENCES Estacionamento (idEstacionamento),
	FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa)
);

INSERT INTO Sensor (fkEstacionamento, fkEmpresa) VALUES 
-- id1:
(1, 1),
-- id2:
(2, 1),
-- id3:
(3, 2),
-- id4:
(4, 2),
-- id5:
(5, 3),
-- id6:
(6, 3);


-- Tabela Dados [relação N:1 com Sensor]:

CREATE TABLE Dados (
	idDados INT AUTO_INCREMENT,
	data DATE,
	hora TIME,
	state TINYINT,
	fkSensor INT,
	fkEstacionamento INT,
	fkEmpresa INT,
	PRIMARY KEY (idDados, fkSensor, fkEstacionamento, fkEmpresa),
	FOREIGN KEY (fkSensor) REFERENCES Sensor (idSensor),
	FOREIGN KEY (fkEstacionamento) REFERENCES Estacionamento (idEstacionamento),
	FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa)
);

-- Quando a PK é composta podemos repetir elas no insert? E quando é FK?
INSERT INTO Dados (data, hora, state, fkSensor, fkEstacionamento, fkEmpresa) VALUES 
-- id:1
-- [Entrada]: Sensor1, Estacionamento1, Empresa1
('2022-04-26', '12:00:00', 1, 1, 1, 1),
-- id:2
-- [Saída]: Sensor1, Estacionamento1, Empresa1
('2022-04-26', '13:00:00', 0, 1, 1, 1),


-- [Entrada]: Sensor2, Estacionamento2, Empresa1
('2022-04-26', '12:00:00', 1, 2, 2, 1),
-- [Saída]: Sensor2, Estacionamento2, Empresa1
('2022-04-26', '13:00:00', 0, 2, 2, 1),



-- [Entrada]: Sensor3, Estacionamento3, Empresa2
('2022-04-26', '12:00:00', 1, 3, 3, 2),
-- [Saída]: Sensor3, Estacionamento3, Empresa2
('2022-04-26', '13:00:00', 0, 3, 3, 2),


-- [Entrada]: Sensor4, Estacionamento4, Empresa2
('2022-04-26', '12:00:00', 1, 4, 4, 2),
-- [Saída]: Sensor4, Estacionamento4, Empresa2
('2022-04-26', '13:00:00', 0, 4, 4, 2),



-- [Entrada]: Sensor5, Estacionamento5, Empresa3
('2022-04-26', '12:00:00', 1, 5, 5, 3),
-- [Saída]: Sensor5, Estacionamento5, Empresa3
('2022-04-26', '13:00:00', 0, 5, 5, 3),

-- [Entrada]: Sensor6, Estacionamento6, Empresa3
('2022-04-26', '12:00:00', 1, 6, 6, 3),
-- [Saída]: Sensor6, Estacionamento6, Empresa3
('2022-04-26', '13:00:00', 0, 6, 6, 3);


