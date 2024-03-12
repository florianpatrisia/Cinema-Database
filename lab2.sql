go
use CINEMA
go


--Cinema
INSERT INTO Cinema(nume, adresa, capacitate) VALUES ('Dacia', 'strada Scolii, nr. 78', 700), 
('Arta', 'strada Progresului, nr. 108', 500), 
('Progresul', 'strada Zorilor, nr. 34', 66400), 
('Florin Piersic', 'strada Muncii, nr. 78', 4500),
('Cinema City', 'strada Viilor, nr. 15', 67000),
('Gloria', 'strada Rozelor, nr. 23', 1000)
--select * from Cinema;

--Gen
INSERT INTO Gen(gen , varsta) VALUES ('animatie', 5),
('comedie', 8), ('actiune', 12), ('drama', 15), ('aventura', 12),
('musical', 10), ('documentar', 15), ('istoric', 15),('romanta', 12);
INSERT INTO Gen (gen, varsta)  VALUES ('science-fiction', 15) 
--select * from Gen


--Film
INSERT INTO Film(nume, regizor, nota, durata, an) VALUES 
('Titanic', 'James Cameron',8.9,  195, 1997), 
('Singur acasa', 'Chris Columbus',7.7, 103, 1990)
,('Forrest Gump','Robert Zemeckis',8.8, 144, 1994),
('Avatar', 'James Cameron',7.9, 162, 2009),
('Iron Man', 'Jon Favreau',7.9, 126, 2008),
('The Godfather', 'Francis Ford Coppola', 9.1, 175, 1972), 
('Avengers:Endgame','Anthony and Joe Russo', 8.3, 183, 2019), 
('Casablanca', 'Michael Curtiz', 8.5, 102, 1942),
('Dancer in the dark', 'Lars von Trier', 7.9, 140 , 2000), 
('Finding Nemo', 'Andrew Stanton', 8.2, 120 , 2003)
INSERT INTO Film(nume, regizor, nota, durata, an) VALUES 
('Harry Potter and the Philosopher s Stone', 'Chris Columbus', 7.6, 152, 2002), 
('Harry Potter  and the Chamber of Secrets', 'Chris Columbus', 7.4, 162, 2008), 
('Harry Potter and the Half -Blood Prince', 'Chris Columbus', 8.6, 152, 2012)
--select * from Film
--SET IDENTITY_INSERT Film OFF;


--FilmGen
INSERT INTO FilmGen(id_film, id_gen) VALUES 
(1,9), (1,5), (1,3), (2,2), (2,3), (3,2), (3, 4),
(4, 10), (5,3), (5, 10), (5, 5), (6, 8), (7,10), 
(8, 8), (8, 9), (9, 6), (10, 1)
--select * from FilmGen


--FilmCinema
INSERT INTO FilmCinema(id_film, id_cinema) VALUES 
(1,1),(1,2),(1,3),(1,4), (1, 5), (1, 6), (2,1),(2,2),(2,3),
(3,4), (3, 5), (3, 6), (4,1),(4,2),(4,3),(4,4), (5, 5), (5, 6), 
(6,1),(6,2),(6,3),(6,4), (7, 5), (7, 6), (7,1),(8,2),(8,3),
(8,4), (9, 5), (9, 6), (9,1),(9,2),(10,3),(10,4), (10, 5), (10, 6)
--select * from FilmCinema


--Bilet
INSERT INTO Bilet(id_film, nr_loc, pret, data_bilet)  VALUES
(1, 36, 20, '2023-12-21'), 
(2, 75, 19, '2023-11-09'), 
(3, 25, 25, '2023-12-16'), 
(4, 112, 26, '2023-08-11'), 
(5, 21, 26, '2023-11-27'), 
(6, 68, 26, '2023-12-5'), 
(7, 83, 40, '2023-12-23'), 
(8, 1, 36, '2023-12-11'), 
(9, 97, 27, '2023-11-01'), 
(10, 48, 33, '2023-11-08')
INSERT INTO Bilet (id_film, nr_loc, pret, data_bilet)  VALUES (1, 25, 20, '2023-12-21'), (2, 77, 19, '2023-11-09')
INSERT INTO Bilet (id_film, nr_loc, pret, data_bilet)  VALUES (1, 26, 20, '2023-12-21')
INSERT INTO Bilet (id_film, nr_loc, pret, data_bilet)  VALUES (1, 27, 20, '2023-12-21')
INSERT INTO Bilet (id_film, nr_loc, pret, data_bilet)  VALUES (1, 28, 20, '2023-12-21')
--select * from Bilet


--Sala
INSERT INTO Sala(id_cinema, capacitate) VALUES 
(1, 60), (2,200), (3,120), (4,300), (5, 249), (6, 308)
--select * from Sala


--Proiectie
INSERT INTO Proiectie(data_difuzare, ora) VALUES 
('2023-11-10', 19), 
('2023-11-11',20), 
('2023-12-12',19), 
('2023-11-05', 17), 
('2023-11-23',13), 
('2023-11-28',16),  
('2023-12-03', 17), 
('2023-12-06',21), 
('2023-11-23',15)
--select * from Proiectie


--CinemaProiectie
INSERT INTO CinemaProiectie(id_cinema, id_proiectie) VALUES 
(1,1),(1,2),(2,3),(2,4), (3, 5), (4, 6), (5, 7), (6, 8), (5, 9)
--select * from CinemaProiectie


--Angajat
INSERT INTO Angajat(id_cinema, nume,experienta,varsta) VALUES 
(1,'Iulia Muresan', 2, 27), 
(2, 'Vasile Pop', 5, 37),
(3,'Cristian Marcel', 1,22),
(4, 'Adelina Adela', 5, 34),
(5, 'Maria Ioana', 1, 23),
(6,'Lavinia Pop', 4,29)


--Abonament
INSERT INTO Abonament(id_cinema, durata, data_incepere, data_finalizare, pret) VALUES 
(1, 30, '2023-11-11','2023-11-12', 300),
(1, 30, '2023-05-11', '2023-05-12', 566),
(1, 30, '2023-18-11', '2023-18-12', 234),
(2, 30, '2023-23-11', '2023-23-12', 453),
(3, 30, '2023-15-11', '2023-15-12', 128),
(6, 30, '2023-01-11', '2023-01-12', 560)
INSERT INTO Abonament(id_cinema, durata, data_incepere, data_finalizare, pret) VALUES 
(4, 30, '2023-11-11', '2023-11-12', 300),
(4, 30, '2023-05-11', '2023-05-12', 566),
(4, 30, '2023-18-11', '2023-18-12', 234)
INSERT INTO Abonament(id_cinema, durata, data_incepere, data_finalizare, pret) VALUES 
(4, 30, '2024-11-11', '2024-11-12', 300),
(4, 30, '2024-05-11', '2024-05-12', 566),
(4, 30, '2024-18-11', '2024-18-12', 234)


select * from Cinema;
select * from Film
select * from Gen
select * from FilmGen
select * from Proiectie
select * from CinemaProiectie
select * from FilmCinema
select * from Bilet
select * from Sala
select * from Angajat
select * from Abonament