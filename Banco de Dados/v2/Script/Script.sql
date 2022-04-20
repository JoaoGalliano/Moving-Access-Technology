CREATE DATABASE MAT;
USE MAT;

CREATE TABLE Empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
cnpj VARCHAR(45)
);

CREATE TABLE Estacionamento (
idEstacionamento INT,
fkEmpresa INT,
PRIMARY KEY (idEstacionamento, fkEmpresa),
endereco VARCHAR(120),
numVagas INT,
FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa)
);

CREATE TABLE Administrador (
idAdministrador INT,
fkEmpresa INT,
admChefe INT,
PRIMARY KEY (idAdministrador, fkEmpresa, admChefe),
nome VARCHAR(45),
sobrenome VARCHAR(45),
email VARCHAR(60),
senha VARCHAR(45),
fkEstacionamento INT,
FOREIGN KEY (fkEstacionamento) REFERENCES Estacionamento (idEstacionamento),
FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa),
FOREIGN KEY (admChefe) REFERENCES Administrador (idAdministrador)
);

CREATE TABLE Sensor (
idSensor INT,
fkEstacionamento INT,
fkEmpresa INT,
PRIMARY KEY (idSensor, fkEstacionamento, fkEmpresa),
state TINYINT,
entrada DATETIME,
saida DATETIME,
FOREIGN KEY (fkEstacionamento) REFERENCES Estacionamento (idEstacionamento),
FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa)
);

CREATE TABLE Dados (
idDados INT,
fkSensor INT,
fkEstacionamento INT,
fkEmpresa INT,
PRIMARY KEY (idDados, fkSensor, fkEstacionamento, fkEmpresa),
dataHora DATETIME,
FOREIGN KEY (fkSensor) REFERENCES Sensor (idSensor),
FOREIGN KEY (fkEstacionamento) REFERENCES Estacionamento (idEstacionamento),
FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa)
);

