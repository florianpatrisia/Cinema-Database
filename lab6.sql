go
use CINEMA
go


-- VALIDARE PENTRU FILM
GO
CREATE FUNCTION ValidareFilm(@Nume VARCHAR(50), @An INT)
RETURNS INT
AS
BEGIN
	DECLARE @valid INT
		SET @valid=1
		if(LEN(@Nume)=0)
		BEGIN
			SET @valid=0
		END
		IF(@An < 1000)
		BEGIN 
			SET @valid=0
		END
		if(@An> 2023)
		BEGIN
			SET @valid=0
		END
	RETURN @valid
END
GO

select max(id_film) from Film
select dbo.ValidareFilm('hahhah', 2002) as result
go

--CRUD pentru Film

-- CREATE Film 
GO
CREATE PROCEDURE insertFilm2 @Nume VARCHAR(50), @An INT, @NrOfRows INT
AS
BEGIN
	DECLARE @id INT
	DECLARE @n INT

	SET @n=1
	WHILE @n<=@NrOfRows
		BEGIN
			SELECT @id=max(id_film) from Film
			SET @id= @id+1
			INSERT INTO Film(id_film, nume, an) VALUES (@id, @Nume, @An)
			SET @n=@n+1
		END

END
GO
SET IDENTITY_INSERT Film ON
GO
-- AICI EXEC INSERT 
exec insertFilm2 @Nume='Testezzzz', @An=2000, @NrOfRows=2

-- READ Film
SELECT * FROM Film
GO

--UPDATE Film
CREATE PROCEDURE updateFilm2 
	@Nume VARCHAR(50), 
	@NumeNou VARCHAR(50)
AS
BEGIN
	UPDATE Film set nume=@NumeNou WHERE nume=@Nume
END
GO

exec updateFilm2 @Nume='Titanic', @NumeNou='Nume Nouuuuu'
SELECT * FROM Film
GO

-- DELETE Film
CREATE PROCEDURE deleteFilm2 @Nume VARCHAR(50), @NrOfRows INT
AS
BEGIN
	--DELETE FROM Bilet
	--DELETE FROM FilmCinema where id_film> (SELECT MAX(id_film)-@NrOfRows FROM Film)
	DELETE FROM FilmGen where id_film> (SELECT MAX(id_film)-@NrOfRows FROM Film)
	DELETE FROM Film WHERE nume=@Nume
END
GO

exec deleteFilm2 @Nume='Titanic', @NrOfRows=0
select * from Film
select * from FilmGen

GO

-- CRUD FILM
CREATE PROCEDURE CRUD_Film @NumeFilm VARCHAR(50),@An INT,  @NrOfRows INT
AS
BEGIN
	DECLARE @NumeFilm1 VARCHAR(50)
	SET @NumeFilm1=@NumeFilm1+'1'
	if (dbo.ValidareFilm(@NumeFilm, @An)=1)
		BEGIN
			-- create
			EXEC insertFilm2 @Nume=@NumeFilm,@An=@An, @NrOfRows=@NrOfRows
			-- read
			SELECT * FROM Film
			-- update
			EXEC updateFilm2 @Nume=@NumeFilm1, @NumeNou=@NumeFilm
			SELECT * FROM Film
			-- DELETE
			EXEC deleteFilm2 @Nume=@NumeFilm1, @NrOfRows=@NrOfRows
			SELECT * FROM Film
			PRINT 'CRUD pentru Film'
		END
		ELSE
		BEGIN
		PRINT 'Eroare de validare la Film!'
			RETURN;
		END
END
GO

exec CRUD_Film @NumeFilm='Test', @An=2021, @NrOfRows=0
exec CRUD_Film @NumeFilm='', @An=2024, @NrOfRows=0




-- CRUD PENTRU GEN
-- VALIDARE PENTRU GEN
GO
CREATE FUNCTION ValidareGen(@Nume VARCHAR(50), @Varsta INT)
RETURNS INT
AS
BEGIN
	DECLARE @valid INT
		SET @valid=1
		if(LEN(@Nume)=0)
		BEGIN
			SET @valid=0
		END
		IF(@Varsta<4)
		BEGIN
			SET @valid=0
		END
	RETURN @valid
END
GO


-- CREATE Gen
GO
CREATE PROCEDURE insertGen @gen VARCHAR(50), @varsta INT, @NrOfRows INT
AS
BEGIN

	DECLARE @id INT
	DECLARE @n INT

	SET @n=1
	WHILE @n<=@NrOfRows
		BEGIN
			SELECT @id=max(id_gen) from Gen
			SET @id= @id+1
			INSERT INTO Gen(id_gen, gen, varsta) VALUES (@id, @gen, @varsta)
			SET @n=@n+1
		END

END
GO

EXEC insertGen @gen='geN 3', @varsta=12, @NrOfRows=1
select * from Gen

-- READ Gen
SELECT * FROM Gen
GO


--UPDATE Gen
CREATE PROCEDURE updateGen @gen VARCHAR(50), @genNou VARCHAR(50)
AS
BEGIN
	UPDATE Gen set gen=@genNou WHERE gen=@gen
END
GO

exec updateGen @gen='gen testtt', @genNou='gen Nouuu'
GO

-- DELETE Gen
CREATE PROCEDURE deleteGen @gen VARCHAR(50), @NrOfRows INT
AS
BEGIN
	--DELETE FROM Bilet
	DELETE FROM FilmGen where id_gen> (SELECT MAX(id_gen)-@NrOfRows FROM Gen)
	DELETE FROM Gen WHERE gen=@gen
	
END
GO

exec deleteGen @gen='gen Nouuu', @NrOfRows=0
select * from Gen
select * from FilmGen

GO

-- CRUD GEN
CREATE PROCEDURE CRUD_Gen @genFilm VARCHAR(50),@varstaGen INT, @NrOfRows INT
AS
BEGIN
	DECLARE @genFilm1 VARCHAR(50)
	SET @genFilm1=@genFilm1+'1'
	if (dbo.ValidareGen(@genFilm, @varstaGen)=1)
		BEGIN
			-- create
			EXEC insertGen @gen=@genFilm,@varsta=@varstaGen, @NrOfRows=@NrOfRows
			-- read
			SELECT * FROM Gen
			-- update
			EXEC updateGen @gen=@genFilm1, @genNou=@genFilm
			SELECT * FROM Film
			-- DELETE
			EXEC deleteGen @gen=@genFilm1, @NrOfRows=@NrOfRows
			SELECT * FROM Gen
			PRINT 'CRUD pentru Gen'
		END
		ELSE
		BEGIN
		PRINT 'Eroare de validare la Gen!'
			RETURN;
		END
END
GO

exec CRUD_Gen @genfilm='hahah',@varstaGen=20, @NrOfRows=1
exec CRUD_Gen @genfilm='',@varstaGen=0, @NrOfRows=1

-- CRUD PENTRU FILM GEN
-- CREATE FilmGen
GO
CREATE PROCEDURE insertFilmGen2
AS
BEGIN
	SET IDENTITY_INSERT Film ON
	exec insertFilm2 @Nume='nume film test', @An=2000, @NrOfRows=1
	SET IDENTITY_INSERT Film OFF

	SET IDENTITY_INSERT Gen ON
	exec insertGen @gen ='gen test', @varsta=5, @NrOfRows=1
	SET IDENTITY_INSERT Gen OFF

	DECLARE @idFilm INT
	DECLARE @idGen INT

	SELECT @idFilm=max(id_film) from Film
	SELECT @idGen=max(id_gen) from Gen
	insert into FilmGen(id_film, id_gen) VALUES (@idFilm, @idGen)
END
GO



CREATE PROCEDURE insertFilmGen3 @NumeFilm VARCHAR(50),@An1 INT, @GenFilm VARCHAR(50), @varsta1 INT
AS
BEGIN
	SET IDENTITY_INSERT Film ON
	exec insertFilm2 @Nume=@NumeFilm, @An=@An1, @NrOfRows=1
	SET IDENTITY_INSERT Film OFF

	SET IDENTITY_INSERT Gen ON
	exec insertGen @gen =@GenFilm, @varsta=@varsta1, @NrOfRows=1
	SET IDENTITY_INSERT Gen OFF

	DECLARE @idFilm INT
	DECLARE @idGen INT

	SELECT @idFilm=max(id_film) from Film
	SELECT @idGen=max(id_gen) from Gen
	insert into FilmGen(id_film, id_gen) VALUES (@idFilm, @idGen)
END
GO

exec insertFilmGen2
--exec insertFilmGen3(@Nume)

select * from Film
select * from Gen
select * from FilmGen


--exec insertFilmGen2

-- READ FilmGen
SELECT * FROM Film
SELECT * FROM Gen
SELECT * FROM FilmGen
GO

--UPDATE FilmGen
CREATE PROCEDURE updateFilmGen
AS
BEGIN
	--DECLARE @idFilm INT
	--DECLARE @idGen INT
	--SELECT @idFilm=max(id_film) from Film
	--SELECT @idGen=max(id_gen) from Gen

	print('Nu este necesar update in tabela FilmGen!');
	--UPDATE FilmGen set gen Where id_film=@idFilm and id_gen=@idGen
	--DELETE FROM FilmGen WHERE id_film = @idFilm;
	--INSERT INTO FilmGen(id_film, id_gen) VALUES (@idFilm, @idGen);
END
GO

exec updateFilmGen
select * from FilmGen
GO

-- DELETE FilmGen
CREATE PROCEDURE deleteFilmGen2
AS
BEGIN
	DECLARE @idFilm INT
	DECLARE @idGen INT
	SELECT @idFilm=max(id_film) from Film
	SELECT @idGen=max(id_gen) from Gen

	DELETE FROM FilmGen where id_film=@idFilm AND id_gen=@idGen
END
GO

exec deleteFilmGen2
select * from FilmGen
GO

-- CRUD FILM GEN
CREATE PROCEDURE CRUD_FilmGen @Nume VARCHAR(50),@An INT,  @genFilm VARCHAR(50), @varsta INT, @NrOfRows INT
AS
BEGIN
	DECLARE @genFilm1 VARCHAR(50)
	DECLARE @numeFilm1 VARCHAR(50)

	SET @genFilm1=@genFilm1+'1'
	SET @numeFilm1=@numeFilm1+'1'


	if (dbo.ValidareGen(@genFilm, @varsta)=1 OR dbo.ValidareFilm(@Nume, @An)=1)
		BEGIN
			-- create
			EXEC insertFilmGen3 @Nume, @An, @GenFilm, @varsta
			-- read
			SELECT * FROM FilmGen
			-- update
			EXEC updateFilmGen
			SELECT * FROM Film
			-- DELETE
			EXEC deleteFilmGen2
			SELECT * FROM Gen
			PRINT 'CRUD pentru Film Gen'
		END
		ELSE
		BEGIN
		PRINT 'Eroare de validare la Gen sau Film!'
			RETURN;
		END
END
GO

exec CRUD_FilmGen @Nume='film', @An=2003, @genFilm='gen', @varsta=50, @NrOfRows=1
exec CRUD_FilmGen @Nume='', @An=2025, @genFilm='testttt', @varsta=0, @NrOfRows=1

GO

CREATE VIEW view_Film
AS
SELECT * FROM Film;
go

CREATE VIEW view_Gen
AS
SELECT * FROM Gen;
go

CREATE VIEW view_FilmGen
AS
SELECT * FROM FilmGen;
go

-- returneaza numarul de filme asociate cu fiecare gen
CREATE VIEW view_Film_Gen AS
SELECT g.gen,  count(f.id_film) as [ nr filme]
FROM Film f INNER JOIN FilmGen fg on fg.id_film=f.id_film
			INNER JOIN Gen g on fg.id_gen=g.id_gen
			GROUP BY g.gen;
go


go

--grupeaza filmele dupa an
CREATE VIEW view_FilmByYear AS
SELECT an, COUNT(*) AS [Nr_Filme] FROM Film
GROUP BY an;

go


select * from Film
--CREATE NONCLUSTERED INDEX IX_Film_Nume ON Film(nume);
--CREATE NONCLUSTERED INDEX IX_Film_An ON Film(an);


select * from view_Film_Gen order by gen
select * from view_FilmByYear order by an


select * from sys.indexes