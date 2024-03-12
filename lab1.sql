Create database CINEMA
go
use CINEMA
go

drop table Bilet
drop table FilmGen
drop table FilmCinema
drop table Abonament
drop table CinemaProiectie
drop table Proiectie
drop table Sala
drop table Angajat
drop table Film
drop table Gen
drop table Cinema



CREATE TABLE Cinema
(id_cinema INT PRIMARY KEY IDENTITY, 
nume varchar(50), 
adresa varchar(50),
capacitate int)


CREATE TABLE Gen
(id_gen INT PRIMARY KEY IDENTITY,
gen varchar(15),
varsta int)

CREATE TABLE Film
(id_film INT PRIMARY KEY IDENTITY, 
nume varchar(50),
durata int,
an int,
regizor varchar(50),
nota float
)


CREATE TABLE Bilet
(id_bilet INT PRIMARY KEY  IDENTITY,
id_film int FOREIGN KEY REFERENCES Film(id_film) ON DELETE CASCADE,
nr_loc int,
pret int,
data_bilet varchar(50))


CREATE TABLE FilmGen
(id_film int FOREIGN KEY REFERENCES Film(id_film) ON DELETE CASCADE,
id_gen int FOREIGN KEY REFERENCES Gen(id_gen) ON DELETE CASCADE,
CONSTRAINT pk_FilmGen PRIMARY KEY (id_film, id_gen))


CREATE TABLE FilmCinema
(id_film INT FOREIGN KEY REFERENCES Film(id_film) ON DELETE CASCADE,
id_cinema INT FOREIGN KEY REFERENCES Cinema(id_cinema) ON DELETE CASCADE,
CONSTRAINT pk_FilmCinema PRIMARY KEY (id_film, id_cinema)
)


CREATE TABLE Abonament
(id_abonament INT PRIMARY KEY IDENTITY,
id_cinema INT FOREIGN KEY REFERENCES Cinema(id_cinema) ON DELETE CASCADE,
durata int,
data_incepere varchar(50),
data_finalizare varchar(50),
pret int)


CREATE TABLE Proiectie
(id_proiectie INT PRIMARY KEY IDENTITY,
data_difuzare varchar(50),
ora int)


CREATE TABLE CinemaProiectie
(
id_cinema INT FOREIGN KEY REFERENCES Cinema(id_cinema) ON DELETE CASCADE,
id_proiectie INT FOREIGN KEY REFERENCES Proiectie(id_proiectie) ON DELETE CASCADE,
CONSTRAINT pk_CinemaProiectie PRIMARY KEY (id_cinema, id_proiectie))


CREATE TABLE Sala
(id_sala INT PRIMARY KEY IDENTITY,
id_cinema INT FOREIGN KEY REFERENCES Cinema(id_cinema)ON DELETE CASCADE,
capacitate int)

CREATE TABLE Angajat
(id_angajat INT PRIMARY KEY IDENTITY,
id_cinema INT FOREIGN KEY REFERENCES Cinema(id_cinema) ON DELETE CASCADE,
nume varchar(50),
experienta INT,
varsta INT
)
