CREATE DATABASE IF NOT EXISTS db_discoteca
COLLATE utf8mb4_general_ci
CHARSET utf8mb4;

USE db_discoteca;

CREATE TABLE IF NOT EXISTS tb_gravadora (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (255) NOT NULL,
CONSTRAINT uq_nome_gravadora UNIQUE (nome)
) AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS tb_genero (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (255) NOT NULL,
CONSTRAINT uq_nome_genero UNIQUE (nome)
) AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS tb_tipo_artista (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (255) NOT NULL,
CONSTRAINT uq_nome_tipo_artista UNIQUE (nome)
) AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS tb_artista (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (255) NOT NULL,
    dt_nascimento DATE,
    id_tipo_artista INTEGER NOT NULL,
CONSTRAINT fk_id_tipo_artista 
FOREIGN KEY (id_tipo_artista) REFERENCES tb_tipo_artista (id) 
) AUTO_INCREMENT = 1;


CREATE TABLE IF NOT EXISTS tb_disco (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR (255) NOT NULL,
    duracao TIME NOT NULL,
    ano_lancamento YEAR NOT NULL,
    id_artista INTEGER,
    id_gravadora INTEGER,
    id_genero INTEGER,
CONSTRAINT fk_id_artista FOREIGN KEY (id_artista) REFERENCES tb_artista (id),
CONSTRAINT fk_id_gravadora FOREIGN KEY (id_gravadora ) REFERENCES tb_gravadora (id),
CONSTRAINT fk_id_genero FOREIGN KEY (id_genero ) REFERENCES tb_genero (id) 
) AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS tb_musica (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (255) NOT NULL,
    duracao TIME NOT NULL,
    id_disco INTEGER NOT NULL,
CONSTRAINT fk_id_disco FOREIGN KEY (id_disco ) REFERENCES tb_disco (id) 
) AUTO_INCREMENT = 1;









