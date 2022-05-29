-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/* para workbench - local - desenvolvimento */
CREATE DATABASE MAT;
USE MAT;

CREATE TABLE Empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	cnpj VARCHAR(20)
);

CREATE TABLE Estacionamento (
	idEstacionamento INT PRIMARY KEY AUTO_INCREMENT,
	cep INT,
	numero INT,
	uf VARCHAR(2),	
	numVagas INT,
	fkEmpresa INT,
	FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa)
);

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

CREATE TABLE Usuario_Estacionamento (
	fkUsuario INT,
	fkEstacionamento INT,
	PRIMARY KEY (fkUsuario, fkEstacionamento),
	FOREIGN KEY (fkUsuario) REFERENCES Usuario (idUsuario),
	FOREIGN KEY (fkEstacionamento) REFERENCES Estacionamento (idEstacionamento)
);

INSERT INTO Dados(data, hora, state, fkSensor, fkEstacionamento, fkEmpresa,) VALUES (curdate(), curtime(), ?, 1, 1, 1)

CREATE TABLE Sensor (
	idSensor  INT PRIMARY KEY AUTO_INCREMENT,
	fkEstacionamento INT,
	fkEmpresa INT,
	FOREIGN KEY (fkEstacionamento) REFERENCES Estacionamento (idEstacionamento),
	FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa)
);

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


/* para sql server - remoto - produção */

CREATE TABLE usuario (
	id INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(50),
	email VARCHAR(50),
	senha VARCHAR(50),
);

CREATE TABLE aviso (
	id INT PRIMARY KEY IDENTITY(1,1),
	titulo VARCHAR(100),
    descricao VARCHAR(150),
	fk_usuario INT FOREIGN KEY REFERENCES usuario(id)
); 

CREATE TABLE medida (
	id INT PRIMARY KEY IDENTITY(1,1),
	temperatura DECIMAL,
	umidade DECIMAL,
	momento DATETIME,
	fk_aquario INT
);


