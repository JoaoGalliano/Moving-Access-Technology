CREATE DATABASE MAT;
USE MAT;

CREATE TABLE Empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
cnpj VARCHAR(20)
);

CREATE TABLE Estacionamento (
idEstacionamento INT PRIMARY KEY AUTO_INCREMENT,
cep VARCHAR(40)
bairro VARCHAR(45),
numVagas INT,
fkEmpresa INT,
FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa)
);

CREATE TABLE Administrador (
idAdministrador INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
sobrenome VARCHAR(45),
email VARCHAR(60),
senha VARCHAR(45),
fkEstacionamento INT,
fkEmpresa INT,
fkAdmChefe INT,
FOREIGN KEY (fkEstacionamento) REFERENCES Estacionamento (idEstacionamento),
FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa),
FOREIGN KEY (fkAdmChefe) REFERENCES Administrador (idAdministrador)
);

CREATE TABLE Administrador_Estacionamento (
	fkAdministrador INT,
	fkEstacionamento INT,
	PRIMARY KEY (fkAdministrador, fkEstacionamento),
	FOREIGN KEY (fkEstacionamento) REFERENCES Estacionamento (idEstacionamento),
	FOREIGN KEY (fkAdministrador) REFERENCES Administrador (idAdministrador)
);

CREATE TABLE Sensor (
idSensor  INT PRIMARY KEY AUTO_INCREMENT,
fkEstacionamento INT,
fkEmpresa INT,
FOREIGN KEY (fkEstacionamento) REFERENCES Estacionamento (idEstacionamento),
FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa)
);

CREATE TABLE Dados (
idDados INT,
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

