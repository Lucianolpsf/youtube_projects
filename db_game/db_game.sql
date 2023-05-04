CREATE DATABASE IF NOT EXISTS db_game
COLLATE utf8mb4_general_ci 
CHARSET utf8mb4;

USE db_game;

CREATE TABLE IF NOT EXISTS tb_jogo (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL
)AUTO_INCREMENT = 1; 

CREATE TABLE IF NOT EXISTS tb_console (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL
)AUTO_INCREMENT = 1; 


CREATE TABLE IF NOT EXISTS tb_jogo_console (
    id_jogo INT NOT NULL,
    id_console INT NOT NULL,
CONSTRAINT fk_id_pai FOREIGN KEY (id_jogo) REFERENCES tb_jogo (id),
CONSTRAINT fk_id_mae FOREIGN KEY (id_console) REFERENCES tb_console (id)
); 








