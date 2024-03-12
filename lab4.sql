go
use CINEMA
go




-- 1. MODIFICARE TIP COLOANA
-- modificare din varchar(50) in varchar(30);
ALTER TABLE Cinema
ALTER COLUMN nume varchar(30);

-- reverse modificare din varchar(30) in varchar(50)
ALTER TABLE Cinema
ALTER COLUMN nume varchar(50);



-- 2. DEFALUT/ ADAUGA O COSTARNGERE DE 'VALOARE IMPLICITA' PE UN CAMP
ALTER TABLE Bilet
ADD CONSTRAINT valoare_default DEFAULT 10 FOR pret;

-- reverse adauga default constraint
ALTER TABLE Bilet
DROP CONSTRAINT valoare_default;


-- 3. CREAZA O TABELA
CREATE TABLE Gustari(
id_locatie INT PRIMARY KEY IDENTITY,
denumire_produs varchar(30),
pret INT);


-- reverse creaza o tabela
DROP TABLE Gustari


-- 4. ADAUGA UN CAMP NOU
ALTER TABLE Gustari
ADD cantitate INT;

-- reverse adauga un camp nou
ALTER TABLE Gustari
DROP COLUMN cantitate;

-- 5. CREAZA O COSTRANGERE DE CHEIE STARINA
ALTER TABLE Gustari
ADD CONSTARINT fk_gustari FOREIGN KEY(id_locatie) references Cinema(id_cinema);


-- remove constarint
ALTER TABLE Gustari
DROP CONSTRAINT fk_gustari;


-- creez tabel Versiune 
CREATE TABLE Versiune
(NrVersiune INT PRIMARY KEY);

INSERT INTO Versiune(NrVersiune) VALUES(0);

UPDATE Versiune
SET NrVersiune=0;
GO

SELECT * FROM Versiune;
GO

CREATE PROCEDURE p1 AS
BEGIN
	ALTER TABLE Cinema
	ALTER COLUMN nume varchar(300);
	print 'Am modificat coloana nume din tablelul Cinema'
END 
GO

EXEC p1;
GO

CREATE PROCEDURE p11 AS
BEGIN
	ALTER TABLE Cinema
	ALTER COLUMN nume varchar(50);
	print 'Coloana nume din tablelul Cinemaa revenit la valoarea initiala'
END 
GO

EXEC p11;
GO

CREATE PROCEDURE p2 AS
BEGIN
	ALTER TABLE Bilet
	ADD CONSTRAINT valoare_default DEFAULT 10 FOR pret;
	print 'Am adaugat o constrangere default in tabelul Bilet'
END
GO

EXEC p2;
GO

CREATE PROCEDURE p22 AS
BEGIN
	ALTER TABLE Bilet
	DROP CONSTRAINT valoare_default;
	print 'Am sters constrangerea default din tabelul Bilet'
END
GO

EXEC p22;
GO

CREATE PROCEDURE p3 AS
BEGIN
	CREATE TABLE Gustari(
	id_produs INT PRIMARY KEY IDENTITY,
	denumire_produs varchar(30),
	pret INT);
	print 'Am creat o tabela Gustari'
END
GO

EXEC p3;
GO

CREATE PROCEDURE p33 AS
BEGIN
	DROP TABLE Gustari;
	print 'Am sters tabela Gustari'
END
GO

EXEC p33;
GO

CREATE PROCEDURE p4 AS
BEGIN
	ALTER TABLE Gustari
	ADD cantitate INT;
	print 'Am adaugat campul cantitate in tabela Gustari'
END
GO

EXEC p4;
GO

CREATE PROCEDURE p44 AS
BEGIN
	ALTER TABLE Gustari
	DROP COLUMN cantitate;
	print 'Am sters campul cantitate din tabela Gustari'
END
GO

EXEC p44;
GO

CREATE PROCEDURE p5 AS
BEGIN
	ALTER TABLE Gustari
	ADD CONSTRAINT fk_gustari FOREIGN KEY(id_produs)
	references Cinema(id_cinema)
	print 'Am adaugat constrangerea fk in Gustari'
END
GO

EXEC p5;
GO

CREATE PROCEDURE p55 AS
BEGIN
	ALTER TABLE Gustari
	DROP CONSTRAINT fk_gustari;
	print 'Am sters constrangerea fk din Gustari'
END
GO

EXEC p55;
GO


CREATE PROCEDURE main @param INT AS
BEGIN
	DECLARE @versiune INT
	SELECT @versiune= NrVersiune FROM Versiune;

	if(@param is null)
		BEGIN
			RAISERROR('Parametrul nu poate fi null',1,1);
			RETURN 1;
		END

	if(@param<0 OR @param>5)
		BEGIN
			RAISERROR('Parametrul este invalid',1,1);
			RETURN 1;
		END

	if(@param = @versiune)
		BEGIN
			RAISERROR('Tabela e la versiunea curenta',1,1);
			RETURN 1;
		END


	DECLARE @nrProcedura INT;
	DECLARE @numeProcedura VARCHAR(15);

	IF(@versiune<@param)
	BEGIN
		SET @nrProcedura=@versiune+1
		WHILE(@versiune<@param)
			BEGIN
				SET @numeProcedura='p'+CONVERT(varchar, @nrProcedura);
				EXEC @numeProcedura
				SET @nrProcedura=@nrProcedura+1;
				SET @versiune=@versiune+1;
			END
		UPDATE Versiune
			SET NrVersiune=@param;
	END
	ELSE
		BEGIN
		IF(@versiune>@param)
		SET @nrProcedura=@versiune
		WHILE(@versiune>@param)
			BEGIN
				SET @numeProcedura='p'+CONVERT(varchar, @nrProcedura)+CONVERT(varchar, @nrProcedura);
				EXEC @numeProcedura
				SET @nrProcedura=@nrProcedura-1;
				SET @versiune=@versiune-1;
			END
		UPDATE Versiune
			SET NrVersiune=@param;
	END

END
GO



-- EXECUT MAIN
SELECT * FROM Versiune

BEGIN TRY
	EXEC main -15;
END TRY

BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage;
END CATCH
