CREATE DATABASE IF NOT EXISTS db_silicone_ball
COLLATE utf8mb4_general_ci CHARSET utf8mb4;

USE db_silicone_ball;

CREATE TABLE IF NOT EXISTS tb_ball (
	id_ball INT PRIMARY KEY AUTO_INCREMENT,
    size ENUM ('m','g','s'),
    color VARCHAR(15)
)AUTO_INCREMENT=1;
