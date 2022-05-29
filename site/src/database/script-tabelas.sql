-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/* para MySQL - local - Desenvolvimento */

CREATE DATABASE mat;
USE mat;

CREATE TABLE empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	cnpj VARCHAR(20)
);

CREATE TABLE estacionamento (
	idEstacionamento INT PRIMARY KEY AUTO_INCREMENT,
	cep INT,
	numero INT,
	uf VARCHAR(2),	
	numVagas INT,
	fkEmpresa INT,
	FOREIGN KEY (fkEmpresa) REFERENCES empresa (idEmpresa)
);

CREATE TABLE usuario (
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	sobrenome VARCHAR(45),
	email VARCHAR(60),
	senha VARCHAR(45),
	fkEmpresa INT,
	fkAdmChefe INT,
	FOREIGN KEY (fkEmpresa) REFERENCES empresa (idEmpresa),
	FOREIGN KEY (fkAdmChefe) REFERENCES usuario (idUsuario)
);

CREATE TABLE usuario_estacionamento (
	fkUsuario INT,
	fkEstacionamento INT,
	PRIMARY KEY (fkUsuario, fkEstacionamento),
	FOREIGN KEY (fkUsuario) REFERENCES usuario (idUsuario),
	FOREIGN KEY (fkEstacionamento) REFERENCES estacionamento (idEstacionamento)
);

CREATE TABLE sensor (
	idSensor  INT PRIMARY KEY AUTO_INCREMENT,
	fkEstacionamento INT,
	fkEmpresa INT,
	FOREIGN KEY (fkEstacionamento) REFERENCES estacionamento (idEstacionamento),
	FOREIGN KEY (fkEmpresa) REFERENCES empresa (idEmpresa)
);

CREATE TABLE dados (
	idDados INT AUTO_INCREMENT,
	data DATE,
	hora TIME,
	state TINYINT,
	fkSensor INT,
	fkEstacionamento INT,
	fkEmpresa INT,
	PRIMARY KEY (idDados, fkSensor, fkEstacionamento, fkEmpresa),
	FOREIGN KEY (fkSensor) REFERENCES sensor (idSensor),
	FOREIGN KEY (fkEstacionamento) REFERENCES estacionamento (idEstacionamento),
	FOREIGN KEY (fkEmpresa) REFERENCES empresa (idEmpresa)
);

-- CREATE DATABASE acquatec;
/*
USE acquatec;

CREATE TABLE usuario (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
	email VARCHAR(50),
	senha VARCHAR(50)
);

CREATE TABLE aviso (
	id INT PRIMARY KEY AUTO_INCREMENT,
	titulo VARCHAR(100),
	descricao VARCHAR(150),
	fk_usuario INT,
	FOREIGN KEY (fk_usuario) REFERENCES usuario(id)
);

create table aquario (
-- em nossa regra de negócio, um aquario tem apenas um sensor 
	id INT PRIMARY KEY AUTO_INCREMENT,
	descricao VARCHAR(300)
);

-- altere esta tabela de acordo com o que está em INSERT de sua API do arduino

create table medida (
	id INT PRIMARY KEY AUTO_INCREMENT,
	dht11_umidade DECIMAL,
	dht11_temperatura DECIMAL,
	luminosidade DECIMAL,
	lm35_temperatura DECIMAL,
	chave TINYINT,
	momento DATETIME,
	fk_aquario INT,
	FOREIGN KEY (fk_aquario) REFERENCES aquario(id)
);
*/

/* para SQL Server - remoto - Produção */

nosso DATABASE Azure aqui;

-- CREATE DATABASE Azure acquatec;
/*
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

create table aquario (
-- em nossa regra de negócio, um aquario tem apenas um sensor 
	id INT PRIMARY KEY IDENTITY(1,1),
	descricao VARCHAR(300)
);

-- altere esta tabela de acordo com o que está em INSERT de sua API do arduino 

CREATE TABLE medida (
	id INT PRIMARY KEY IDENTITY(1,1),
	dht11_umidade DECIMAL,
	dht11_temperatura DECIMAL,
	luminosidade DECIMAL,
	lm35_temperatura DECIMAL,
	chave TINYINT,
	momento DATETIME,
	fk_aquario INT FOREIGN KEY REFERENCES aquario(id)
);
*/