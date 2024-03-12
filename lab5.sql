go
use CINEMA
go


--TABELE
-- 1 PK, no FK = Film
-- 1 PK + FK = Bilet
-- 2 PK = FilmGen


go
--VIEW
CREATE VIEW view1 AS
SELECT * FROM Film;
go

CREATE VIEW view2 AS
SELECT B.id_bilet, B.data_bilet, b.nr_loc, b.pret
FROM Bilet b inner join Film f on b.id_film=f.id_film;
go

CREATE VIEW view3 as
SELECT g.id_gen, count(f.id_film) as [ nr filme]
FROM Film f INNER JOIN FilmGen fg on fg.id_film=f.id_film
			INNER JOIN Gen g on fg.id_gen=g.id_gen
			GROUP BY g.id_gen;
go

insert into Tables(Name) values
('Film'), 
('Bilet'), 
('FilmGen')
go

select * from Tables

insert into Views(Name) values
('view1'),
('view2'),
('view3')
go

go

--INSERT
-- insert tabelã având un câmp ca ºi cheie primarã ºi nici o cheie strãinã
create or alter procedure insertFilm
@NoOfRows int
as 
DECLARE @n int 
DECLARE @nume VARCHAR(50)
DECLARE @d int
DECLARE @a int
DECLARE @r VARCHAR(50)
DECLARE @nota float

SELECT TOP 1 @NoOfRows= @NoOfRows from dbo.TestTables 
SET @n=@n+1

WHILE @n<@NoOfRows
BEGIN
SET @nume='Film'+ convert(varchar(5), @n)
INSERT INTO Film(id_film, nume, durata, an, regizor, nota) VALUES (@n, @nume, @d, @a, @r, @nota)
SET @n=@n+1
END
go

SET IDENTITY_INSERT Bilet ON
go
select * from Film
go

-- insert  tabelã având un câmp ca ºi cheie primarã ºi cel puþin o cheie strãinã
create or alter procedure insertBilet
@NoOfRows int
as 
DECLARE @n int 
DECLARE @fk int 
DECLARE @nr int
DECLARE @p int
DECLARE @d VARCHAR(50)

SELECT TOP 1 @fk=min(id_film) from Film
SELECT TOP 1 @n= id_bilet from Bilet order by id_bilet desc
SET @n=@n+1
WHILE @n<@NoOfRows
BEGIN
INSERT INTO Bilet(id_bilet, id_film, nr_loc, pret, data_bilet) values(@n, @fk, @nr, @p, @d)
SET @n=@n+1
END
go

-- insert  tabelã având douã câmpuri ca ºi cheie primarã
create or alter procedure insertFilmGen
@NoOfRows int
as
DECLARE @n int
DECLARE @fk int
DECLARE @fk1 int

SELECT TOP 1 @fk=id_film FROM Film
SELECT TOP 1 @fk1=id_gen FROM Gen

WHILE @n<@NoOfRows
BEGIN
INSERT INTO FilmGen (id_film, id_gen) values (@fk, @fk1)
SET @n=@n+1
END

go


--DELETE
-- delete tabelã având un câmp ca ºi cheie primarã ºi nici o cheie strãinã
create or alter procedure deleteFilm
@nr int
as 
delete from Film
go

-- delete tabelã având un câmp ca ºi cheie primarã ºi cel puþin o cheie strãinã
create or alter procedure deleteBilet
@nr int
as 
delete from Bilet
go 

-- delete tabelã având douã câmpuri ca ºi cheie primarã
create or alter procedure deleteFilmGen
@nr int
as 
delete from FilmGen
go


--SELECT
-- delete tabelã având un câmp ca ºi cheie primarã ºi nici o cheie strãinã
create or alter procedure selectFilm
@nr int
as 
begin
	select top (@nr) * from Film
end
go

-- delete tabelã având un câmp ca ºi cheie primarã ºi cel puþin o cheie strãinã
create or alter procedure selectBilet
@nr int
as
begin
	select top (@nr) * from Bilet
end
go

-- select tabelã având douã câmpuri ca ºi cheie primarã
create or alter procedure selectFilmGen
@nr int
as
begin
	select top (@nr) * from FilmGen
end


insert into Tests(Name) values
	('insertFilm'),
	('insertBilet'),
	('insertFilmGen'),
	('selectFilm'),
	('selectBilet'),
	('selectFilmGen'),
	('deleteFilm'),
	('deleteBilet'),
	('deleteFilmGen')

--select * from FilmCinema
--select * from Film
--select * from Cinema
--select * from Tests
--drop table Tables
--drop table TestRuns
--drop table TestRunTables
--drop table TestRunViews
--drop table Tests
--drop table TestTables
--drop table TestViews
--drop table Views


insert into TestViews(TestID, ViewID) values
(4, 1),
(5, 2),
(6, 3)

select * from TestViews


insert into TestTables(TestID, TableID, NoOfRows, Position)
values
(1, 3, 100, 1),
(9, 2, 100, 2),
(2, 1, 500, 3),
(8, 1, 500, 4),
(3, 2, 1000, 5),
(7, 3, 1000, 6)
go


select * from TestTables

set nocount on
go

create or alter procedure runTests
as
begin

	declare @i int = 1
	
	declare @posMax int
	select @posMax = max(Position) from TestTables

	declare @startAll datetime = getdate()
	declare @testId0 int
	select @testId0 = max(TestRunID) from TestRuns

	insert into TestRuns(TestRuns.Description, StartAt, EndAt) values ('FirstTest', @startAll, @startAll)


	while @i <= @posMax
	begin
		
		declare @testId int
		declare @tableId int
		declare @procName varchar(64)
		declare @noRows int
		declare @commId int

		select @testId = TestID from TestTables where Position = @i 
		select @tableId  = TableID from TestTables where Position = @i
		select @noRows = NoOfRows from TestTables where Position = @i

		select @procName = Tests.Name from Tests where TestID = @testId
		
		declare @startTableTest datetime = getdate()
		exec @procName @noRows


		declare @viewStart datetime = getdate()
		select @commId = ViewID from TestViews where TestID = @tableId - 3
		select @procName = Tests.Name from Tests where TestID = @commId
		exec @procName @noRows
		declare @viewEnd datetime = getdate()
		insert into TestRunViews values(@testId0, @tableId, @viewStart, @viewEnd)		
	


		set @i = @i + 1
		select @testId = TestID from TestTables where Position = @i 
		select @tableId  = TableID from TestTables where Position = @i
		select @noRows = NoOfRows from TestTables where Position = @i

		select @procName = Tests.Name from Tests where TestID = @testId
		exec @procName @noRows

		declare @endTableTest datetime = getdate()

		insert into TestRunTables values(@testId0, @tableId, @startTableTest, @endTableTest)

		set @i = @i + 1
		
	end

	declare @endAll datetime = getdate()
	update TestRuns set EndAt = @endAll where StartAt = @startAll

end
go



exec runTests

--select * from Bilet
--drop table Bilet

select * from TestRunTables
select * from TestRunViews
select * from TestRuns