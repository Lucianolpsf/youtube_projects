
-- Para detalhes recomendamos que leia rapidamente nosso arquivo README.
-- Bons estudos! 

-- --------------------------------------Criando a database ----------------------------------------------------

CREATE DATABASE  db_discoteca
ON PRIMARY (
NAME = db_discoteca,
FILENAME ='C:\SQL Server\db_discoteca.MDF', -- Recomendamos aqui que crie sua database neste mesmo diretorio, porém você pode mudar caso deseje. 
SIZE = 10MB ,
FILEGROWTH = 30%
)
GO

-- ----------------------------------------- Criando tabelas ----------------------------------------------------

USE db_discoteca
GO

CREATE TABLE gravadora (
    id_gravadora SMALLINT NOT NULL IDENTITY(1,1),
    nome  		 VARCHAR(20) NOT NULL,
CONSTRAINT PK_id_gravadora PRIMARY KEY (id_gravadora)
)
GO

CREATE TABLE artista (
    id_artista SMALLINT NOT NULL IDENTITY(1,1),
    nome VARCHAR(50) NOT NULL,
    dt_nascimento DATE,
CONSTRAINT PK_id_artista PRIMARY KEY (id_artista)
) 
GO

CREATE TABLE genero (
    id_genero SMALLINT NOT NULL IDENTITY(1,1),
    nome VARCHAR(20),
CONSTRAINT PK_id_genero PRIMARY KEY (id_genero)
) 
GO

INSERT INTO gravadora (nome) VALUES ('Independente') 
GO
INSERT INTO artista  (nome)  VALUES ('Desconhecido')
GO
INSERT INTO genero (nome) VALUES ('Outros')
GO

CREATE TABLE disco (
	id_disco SMALLINT NOT NULL IDENTITY(1,1),
    titulo_disco VARCHAR(50)  NOT NULL,
    tempo_disco FLOAT NOT NULL DEFAULT '0',
	dt_lancamento DATE NOT NULL,
    id_artista SMALLINT  NOT NULL DEFAULT '1',
    id_gravadora SMALLINT NOT NULL DEFAULT '1',
    id_genero SMALLINT NOT NULL DEFAULT '1',
CONSTRAINT PK_id_disco 	     PRIMARY KEY (id_disco),
CONSTRAINT FK_id_artista     FOREIGN KEY (id_artista)   REFERENCES artista (id_artista),
CONSTRAINT FK_id_gravadora   FOREIGN KEY (id_gravadora) REFERENCES gravadora (id_gravadora),
CONSTRAINT FK_id_genero 	 FOREIGN KEY (id_genero)    REFERENCES genero (id_genero)
)
GO

CREATE TABLE musica (
    id_musica SMALLINT NOT NULL IDENTITY(1,1),
    nome VARCHAR(50) NOT NULL,
    tempo_musica FLOAT,
    id_disco SMALLINT NOT NULL,
CONSTRAINT CK_tempo_musica CHECK (tempo_musica >=0 AND tempo_musica <=20), -- valida o tempo de cada musica entre 0 a 20 minutos
CONSTRAINT PK_id_musica PRIMARY KEY (id_musica),
CONSTRAINT FK_id_disco  FOREIGN KEY (id_disco) REFERENCES disco (id_disco) ON DELETE CASCADE
)
GO


--  --------------------------------- Criando triggers para automatizar certos campos e rotinas -------------------------------------

CREATE OR ALTER TRIGGER TR_tempo_disco
ON musica
AFTER INSERT
AS
	BEGIN
		DECLARE @total_musica FLOAT;
		DECLARE @codigo_disco INT;
		        
		SELECT @codigo_disco = id_disco FROM INSERTED;
		
		SET @total_musica = (SELECT SUM(tempo_musica) FROM musica WHERE id_disco = @codigo_disco);

		UPDATE disco SET tempo_disco = @total_musica WHERE id_disco =  @codigo_disco;
    END
GO

-- ------------------------------ Criando views para proteger a integridade de nossas tabelas ----------------------------------------------

CREATE OR ALTER VIEW vw_gravadoras AS
SELECT gravadoras.codigo, gravadoras.gravadora, COUNT(gravadoras.codigo_disco) AS 'quantidade gravadoras'
FROM
(SELECT g.id_gravadora AS codigo,
		g.nome AS gravadora, 
		d.id_disco AS codigo_disco
 FROM gravadora g
 LEFT JOIN disco d ON d.id_gravadora = g.id_gravadora
) AS gravadoras
GROUP BY gravadoras.codigo, gravadoras.gravadora
GO

CREATE OR ALTER VIEW vw_discos AS
SELECT  d.id_disco 'Codigo do disco',
		d.titulo_disco 'Titulo do Disco', 
		d.tempo_disco 'Tempo do disco',
        d.dt_lancamento 'Ano de lancamento',
        a.nome artista,
        ge.nome genero ,
        g.nome gravadora
FROM disco d 
JOIN gravadora g
	ON d.id_gravadora = g.id_gravadora
JOIN artista a
	ON d.id_artista = a.id_artista
JOIN genero ge
	ON d.id_genero = ge.id_genero;
GO

CREATE OR ALTER VIEW vw_musicas AS
SELECT m.nome 'Musica', 
		m.tempo_musica 'Duracao',
        d.titulo_disco Disco,
        a.nome Artista
FROM musica m
JOIN disco d
	ON d.id_disco = m.id_disco
JOIN artista a
	ON a.id_artista = d.id_artista
GO

CREATE OR ALTER VIEW vw_artistas AS
SELECT artistas.codigo, artistas.artista, artistas.idade, COUNT(artistas.codigo_disco) AS 'quantidade discos' 
FROM
(SELECT  
	a.id_artista codigo,
    a.nome artista,
	CASE 
		WHEN a.dt_nascimento IS NULL THEN '0'
		ELSE  (SELECT (DATEDIFF(DAY,a.dt_nascimento,GETDATE())))/365
	END "idade",
	d.id_disco AS codigo_disco
FROM artista a
LEFT JOIN disco d 
	ON d.id_artista = a.id_artista
) AS artistas
GROUP BY artistas.codigo, artistas.artista, artistas.idade
GO


-- ------------------------------ Criando fun��es -----------------------------------------------

CREATE OR ALTER FUNCTION fn_inicial_maiuscula (@texto varchar(250))
RETURNS VARCHAR(250)
AS
BEGIN
	DECLARE @posicao tinyint = 1
	DECLARE @retorno varchar(250) = ''

	WHILE (@posicao < LEN(@texto) + 1)
		BEGIN
			IF @posicao = 1
				BEGIN
					SET @retorno += UPPER(SUBSTRING(@texto, @posicao, 1)) --FORMATA 1.LETRA DA "FRASE"
				END
			ELSE IF (SUBSTRING(@texto, (@posicao-1), 1) = ' ' AND SUBSTRING(@texto, (@posicao+2), 1) <> ' ') AND (@posicao+1) <> LEN(@texto)
				BEGIN
					SET @retorno += UPPER(SUBSTRING(@texto, @posicao, 1)) --FORMATA 1.LETRA DE "CADA INTERVALO""
				END
			ELSE
				BEGIN
					SET @retorno += LOWER(SUBSTRING(@texto,@posicao, 1)) --FORMATA CADA LETRA RESTANTE
				END

			SET @posicao += 1
		END

  RETURN @retorno
END
GO

-- ------------------------------------------Criando Procedures -----------------------------


CREATE OR ALTER PROCEDURE sp_insert_gravadora (@g_nome VARCHAR(20)) AS
BEGIN
	INSERT INTO gravadora (nome) VALUES (dbo.fn_inicial_maiuscula(@g_nome))
END 
GO

CREATE OR ALTER PROCEDURE sp_insert_genero (@ge_nome VARCHAR(20)) AS
BEGIN
	INSERT INTO genero (nome) VALUES (dbo.fn_inicial_maiuscula(@ge_nome))
END 
GO

CREATE OR ALTER PROCEDURE sp_insert_artista (@a_nome VARCHAR(50), @nascimento DATE) AS
BEGIN
	DECLARE @valida_data DATE;
	SET @valida_data = (SELECT GETDATE());
    
		IF NOT (@nascimento <= @valida_data)
			
				RETURN 'Data invalida'
            ELSE 
				INSERT INTO artista (nome, dt_nascimento) VALUES (dbo.fn_inicial_maiuscula(@a_nome), @nascimento) 
END 
GO

CREATE OR ALTER PROCEDURE sp_insert_disco (@d_titulo VARCHAR(50), @ano_lancamento DATE, @cod_artista INT , @cod_gravadora INT, @cod_genero INT) AS
BEGIN
	DECLARE @valida_ano DATE; 
	DECLARE @valida_artista INT;
    DECLARE @valida_gravadora INT; 
    DECLARE @valida_genero INT;
        
	SET @valida_ano = (SELECT GETDATE());
    SET @valida_artista = (SELECT MAX(id_artista) FROM artista);
    SET @valida_gravadora = (SELECT MAX(id_gravadora) FROM gravadora);
    SET @valida_genero = (SELECT MAX(id_genero) FROM genero);


	IF NOT(@ano_lancamento <= @valida_ano)
		RETURN 'Ano invalido'
          
    ELSE IF (@ano_lancamento <= @valida_ano)      
		BEGIN
				IF @cod_artista > @valida_artista 
					SET @cod_artista = '1';
					
				IF @cod_gravadora > @valida_gravadora 
					SET @cod_gravadora = '1';
					
				IF @cod_genero > @valida_genero
					SET @cod_genero = '1';
				            
				INSERT INTO disco (titulo_disco, dt_lancamento, id_artista, id_gravadora,id_genero) VALUES (dbo.fn_inicial_maiuscula(@d_titulo), @ano_lancamento, @cod_artista, @cod_gravadora, @cod_genero);
		END
	ELSE 

		INSERT INTO disco (titulo_disco, dt_lancamento, id_artista, id_gravadora,id_genero) VALUES (dbo.fn_inicial_maiuscula(@d_titulo), @ano_lancamento, @cod_artista, @cod_gravadora, @cod_genero);

	END
GO

CREATE OR ALTER PROCEDURE sp_insert_musica (@titulo VARCHAR(50),@duracao FLOAT, @cod_disco INT) AS
BEGIN
	DECLARE @valida_disco INT;
    SET @valida_disco = (SELECT MAX(id_disco) FROM disco);
    
    IF @cod_disco > @valida_disco OR @cod_disco < '0' 
		RETURN 'Disco invalido';
	ELSE IF @duracao < 0
		RETURN 'Duracao de musica invalida';
	ELSE
		INSERT INTO musica (nome, tempo_musica, id_disco) VALUES (dbo.fn_inicial_maiuscula(@titulo), @duracao, @cod_disco);
END
GO