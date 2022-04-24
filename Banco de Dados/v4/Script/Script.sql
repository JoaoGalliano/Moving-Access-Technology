CREATE DATABASE MAT;
USE MAT;


-- Tabela Empresa:

CREATE TABLE Empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	cnpj VARCHAR(20)
);

+-----------+-------------+------+-----+---------+----------------+
| Field     | Type        | Null | Key | Default | Extra          |
+-----------+-------------+------+-----+---------+----------------+
| idEmpresa | int         | NO   | PRI | NULL    | auto_increment |
| nome      | varchar(45) | YES  |     | NULL    |                |
| cnpj      | varchar(20) | YES  |     | NULL    |                |
+-----------+-------------+------+-----+---------+----------------+

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
	cep INT,
	numero INT,
	uf VARCHAR(2),	
	numVagas INT,
	fkEmpresa INT,
	FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa)
);

//

INSERT INTO Estacionamento (cep, numero, uf, numVagas, fkEmpresa) VALUES 
-- id1:
(01310916, 1374, 'SP', 600, 1),
-- id2:
(01046001, 112, 'SP', 450, 1),
-- id3:
(01332000, 636, 'SP', 200, 2),
-- id4:
(01318000, 306, 'SP', 300, 2),
-- id5:
(01301000, 247, 'SP', 400, 3),
-- id6:
(01412000, 1808, 'SP', 250, 3);


-- Tabela Usuario [relação n:1 com Empresa]:

CREATE TABLE Usuario (
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	sobrenome VARCHAR(45),
	email VARCHAR(60),
	senha VARCHAR(45),
	fkEmpresa INT,
	fkAdmChefe INT,
	FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa),
	FOREIGN KEY (fkAdmChefe) REFERENCES Usuario (idUsuario)
);

+-----------------+-------------+------+-----+---------+----------------+
| Field           | Type        | Null | Key | Default | Extra          |
+-----------------+-------------+------+-----+---------+----------------+
| idUsuario       | int         | NO   | PRI | NULL    | auto_increment |
| nome            | varchar(45) | YES  |     | NULL    |                |
| sobrenome       | varchar(45) | YES  |     | NULL    |                |
| email           | varchar(60) | YES  |     | NULL    |                |
| senha           | varchar(45) | YES  |     | NULL    |                |
| fkEmpresa       | int         | YES  | MUL | NULL    |                |
| fkAdmChefe      | int         | YES  | MUL | NULL    |                |
+-----------------+-------------+------+-----+---------+----------------+

INSERT INTO Usuario (nome, sobrenome, email, senha, fkEmpresa, fkAdmChefe) VALUES
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



-- Tabela Usuario_Estacionamento [relação N:m Usuario_has_Estacionamento]:

CREATE TABLE Usuario_Estacionamento (
	fkUsuario INT,
	fkEstacionamento INT,
	PRIMARY KEY (fkUsuario, fkEstacionamento),
	FOREIGN KEY (fkUsuario) REFERENCES Usuario (idUsuario),
	FOREIGN KEY (fkEstacionamento) REFERENCES Estacionamento (idEstacionamento)
);

+------------------+------+------+-----+---------+-------+
| Field            | Type | Null | Key | Default | Extra |
+------------------+------+------+-----+---------+-------+
| fkUsuario        | int  | NO   | PRI | NULL    |       |
| fkEstacionamento | int  | NO   | PRI | NULL    |       |
+------------------+------+------+-----+---------+-------+

INSERT INTO Usuario_Estacionamento (fkUsuario, fkEstacionamento) VALUES 
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

+------------------+------+------+-----+---------+----------------+
| Field            | Type | Null | Key | Default | Extra          |
+------------------+------+------+-----+---------+----------------+
| idSensor         | int  | NO   | PRI | NULL    | auto_increment |
| fkEstacionamento | int  | YES  | MUL | NULL    |                |
| fkEmpresa        | int  | YES  | MUL | NULL    |                |
+------------------+------+------+-----+---------+----------------+

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

+------------------+---------+------+-----+---------+----------------+
| idDados          | int     | NO   | PRI | NULL    | auto_increment |
| data             | date    | YES  |     | NULL    |                |
| hora             | time    | YES  |     | NULL    |                |
| state            | tinyint | YES  |     | NULL    |                |
| fkSensor         | int     | NO   | PRI | NULL    |                |
| fkEstacionamento | int     | NO   | PRI | NULL    |                |
| fkEmpresa        | int     | NO   | PRI | NULL    |                |
+------------------+---------+------+-----+---------+----------------+

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



-- SELECTS

SELECT * FROM Empresa;

+-----------+-------------+----------------+
| idEmpresa | nome        | cnpj           |
+-----------+-------------+----------------+
|         1 | Estapar     | 72423437000149 |
|         2 | MultiPark   | 31985344000120 |
|         3 | Stop & Park | 57410487000106 |
+-----------+-------------+----------------+


SELECT * FROM Estacionamento;

//


SELECT * FROM Usuario;

+-----------------+--------+-------------+----------------------+----------+-----------+------------+
| idUsuario       | nome   | sobrenome   | email                | senha    | fkEmpresa | fkAdmChefe |
+-----------------+--------+-------------+----------------------+----------+-----------+------------+
|               1 | Karen  | Albuquerque | Karen@estapar.com    | IEX22dbI |         1 |       NULL |
|               2 | Robert | Pereira     | Robert@estapar.com   | 5Switbxz |         1 |          1 |
|               3 | Miguel | Ferrari     | Miguel@multipark.com | ck5ZbpTZ |         2 |       NULL |
|               4 | Monica | Costa       | Monica@multipark.com | UKu7TF5d |         2 |          3 |
|               5 | Alice  | Nakamura    | Alice@stoppark.com   | JSWBxyKr |         3 |       NULL |
|               6 | Pedro  | Gomes       | Pedro@stoppark.com   | G6P1YDq1 |         3 |          5 |
+-----------------+--------+-------------+----------------------+----------+-----------+------------+


SELECT * FROM Usuario_Estacionamento;

+-----------------+------------------+
| fkUsuario       | fkEstacionamento |
+-----------------+------------------+
|               1 |                1 |
|               2 |                2 |
|               3 |                3 |
|               4 |                4 |
|               5 |                5 |
|               6 |                6 |
+-----------------+------------------+


SELECT * FROM Sensor;

+----------+------------------+-----------+
| idSensor | fkEstacionamento | fkEmpresa |
+----------+------------------+-----------+
|        1 |                1 |         1 |
|        2 |                2 |         1 |
|        3 |                3 |         2 |
|        4 |                4 |         2 |
|        5 |                5 |         3 |
|        6 |                6 |         3 |
+----------+------------------+-----------+


SELECT * FROM Dados;

+---------+------------+----------+-------+----------+------------------+-----------+
| idDados | data       | hora     | state | fkSensor | fkEstacionamento | fkEmpresa |
+---------+------------+----------+-------+----------+------------------+-----------+
|       1 | 2022-04-26 | 12:00:00 |     1 |        1 |                1 |         1 |
|       2 | 2022-04-26 | 13:00:00 |     0 |        1 |                1 |         1 |
|       3 | 2022-04-26 | 12:00:00 |     1 |        2 |                2 |         1 |
|       4 | 2022-04-26 | 13:00:00 |     0 |        2 |                2 |         1 |
|       5 | 2022-04-26 | 12:00:00 |     1 |        3 |                3 |         2 |
|       6 | 2022-04-26 | 13:00:00 |     0 |        3 |                3 |         2 |
|       7 | 2022-04-26 | 12:00:00 |     1 |        4 |                4 |         2 |
|       8 | 2022-04-26 | 13:00:00 |     0 |        4 |                4 |         2 |
|       9 | 2022-04-26 | 12:00:00 |     1 |        5 |                5 |         3 |
|      10 | 2022-04-26 | 13:00:00 |     0 |        5 |                5 |         3 |
|      11 | 2022-04-26 | 12:00:00 |     1 |        6 |                6 |         3 |
|      12 | 2022-04-26 | 13:00:00 |     0 |        6 |                6 |         3 |
+---------+------------+----------+-------+----------+------------------+-----------+


SELECT CONCAT(Usuario.nome, " ", Usuario.sobrenome) AS Usuario, Usuario.email AS Email, 
Usuario.senha AS Senha, CONCAT(AdmChefe.nome," ", AdmChefe.sobrenome) AS Administrador
FROM Usuario JOIN Usuario as AdmChefe ON Usuario.fkAdmChefe = AdmChefe.idUsuario;

//


//SELECT Estacionamento.idEstacionamento AS "Nº Estacionamento", Estacionamento.cep AS CEP, Estacionamento.endereco AS Endereço, Empresa.nome AS Empresa, Empresa.cnpj AS CNPJ 
FROM Estacionamento JOIN Empresa ON fkEmpresa = idEmpresa;

//


SELECT Sensor.idSensor AS "Nº Sensor", Dados.state AS "Entra = 1 /Saida = 0", Dados.data AS Data, Dados.hora AS Hora 
FROM Sensor JOIN Dados ON fkSensor = idSensor; 

+-----------+----------------------+------------+----------+
| Nº Sensor | Entra = 1 /Saida = 0 | Data       | Hora     |
+-----------+----------------------+------------+----------+
|         1 |                    1 | 2022-04-26 | 12:00:00 |
|         1 |                    0 | 2022-04-26 | 13:00:00 |
|         2 |                    1 | 2022-04-26 | 12:00:00 |
|         2 |                    0 | 2022-04-26 | 13:00:00 |
|         3 |                    1 | 2022-04-26 | 12:00:00 |
|         3 |                    0 | 2022-04-26 | 13:00:00 |
|         4 |                    1 | 2022-04-26 | 12:00:00 |
|         4 |                    0 | 2022-04-26 | 13:00:00 |
|         5 |                    1 | 2022-04-26 | 12:00:00 |
|         5 |                    0 | 2022-04-26 | 13:00:00 |
|         6 |                    1 | 2022-04-26 | 12:00:00 |
|         6 |                    0 | 2022-04-26 | 13:00:00 |
+-----------+----------------------+------------+----------+


//SELECT Empresa.nome AS "Nome da Empresa", Empresa.cnpj AS CNPJ, Estacionamento.idEstacionamento AS "Nº Estacionamento", Estacionamento.endereco AS "Endereço", 
Sensor.idSensor AS "Nº Sensor", Dados.state AS "Entra = 1 /Saida = 0", Dados.data AS "Data", Dados.hora AS Hora  
FROM Dados JOIN Empresa ON fkEmpresa = idEmpresa JOIN Estacionamento ON fkEstacionamento = idEstacionamento JOIN Sensor ON fkSensor = idSensor;  

//


//SELECT Empresa.nome AS "Nome da Empresa", Empresa.cnpj AS CNPJ, CONCAT(Administrador.nome, " ", Administrador.sobrenome) AS Administrador,
CONCAT(AdmChefe.nome," ", AdmChefe.sobrenome) AS "Administrador Chefe", Estacionamento.idEstacionamento AS "Nº Estacionamento",
Estacionamento.endereco AS Endereço, Sensor.idSensor AS "Nº Sensor", Dados.state AS "Entra = 1 /Saida = 0", Dados.data AS Data, Dados.hora AS Hora  
FROM Dados JOIN Empresa ON fkEmpresa = idEmpresa JOIN Estacionamento ON fkEstacionamento = idEstacionamento JOIN Sensor ON fkSensor = idSensor 
JOIN Administrador ON Administrador.fkEmpresa = Empresa.idEmpresa JOIN Administrador as AdmChefe ON Administrador.fkAdmChefe = AdmChefe.idAdministrador;

//

