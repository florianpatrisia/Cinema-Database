go
use CINEMA
go

-- returneaza numele cinematografelor si nr. angajatilor acelui cinema si nr salilor pentru care capacitatea este mai mare de 300
--3  angajat, cinema, sala
SELECT  c.nume,COUNT(DISTINCT A.id_angajat) AS nr_angajati, COUNT(DISTINCT s.id_sala)as nr_sali
FROM Angajat a INNER JOIN Cinema c ON a.id_cinema=c.id_cinema
INNER JOIN Sala s on s.id_cinema=c.id_cinema
WHERE c.capacitate>300
GROUP BY  c.nume

-- selecteaza toate filmele ale caror nota este mai mare decat 8.5
SELECT nume, durata, nota
FROM Film
WHERE nota>8.5

-- afiseaza numele si adresa unui cinema, unde lucreaza un angajat cu o experienta mai mare de 3 ani si cu varsta mai mica de 30 de ani
SELECT  c.nume,c.adresa, a.nume
FROM Angajat a, Cinema c
WHERE a.experienta>3 AND a.varsta<30 and a.id_cinema=c.id_cinema

--returneaaza suma tuturor biletelor pentru toate filmele cu genul actiune
--3   bilet, film, gen
Select f.nume, SUM(b.pret) as suma_bilete
FROM Bilet b INNER JOIN Film f ON f.id_film=b.id_film
INNER JOIN FilmGen fg on fg.id_film=f.id_film
INNER JOIN Gen g ON g.id_gen=fg.id_gen
WHERE g.gen='actiune'
GROUP BY f.nume

-- retunreaza numarul de filme si de bilete pentru fiecare cinema
--3   cinema, bilet, film
SELECT c.nume, COUNT(DISTINCT fc.id_film) AS Numar_Filme, COUNT(b.id_bilet) AS Numar_Bilete
FROM Cinema c
LEFT JOIN FilmCinema fc ON c.id_cinema = fc.id_cinema
LEFT JOIN Bilet b ON fc.id_film = b.id_film
GROUP BY c.nume, c.id_cinema


-- returneaza pentru fiecare cinema numarul de sali si abonamente
--3 sala, cinema, abonament
SELECT c.nume, COUNT(DISTINCT s.id_sala) nr_sali, COUNT(a.id_abonament) as nr_abonamente
FROM Sala s INNER JOIN  Cinema c on s.id_cinema=c.id_cinema
INNER JOIN Abonament a on a.id_cinema=c.id_cinema
GROUP BY c.nume


-- returneaza numele cinematografului, id-ul salii si numarul de proiectii pentru fiecare sala din cinema
--group by
--3   cinema, sala , proiectie
SELECT c.nume, s.id_sala, count(DISTINCT p.id_proiectie) as nr_poiectii 
FROM Cinema c INNER JOIN Sala s ON c.id_cinema=s.id_cinema
INNER JOIN CinemaProiectie cp ON c.id_cinema=cp.id_cinema
INNER JOIN Proiectie p ON cp.id_proiectie=p.id_proiectie
GROUP BY c.nume, s.id_sala


-- returneaza filmele si genul lor  pentru care media notelor mai mare decat 8
--group by,having
--film, cinema, gen
--3
SELECT f.nume, g.gen, AVG(f.nota) as medie_note
FROM Gen g INNER JOIN FilmGen fg on g.id_gen=fg.id_gen 
INNER JOIN Film f on f.id_film=fg.id_film
INNER JOIN FilmCinema fc on fc.id_film=f.id_film
INNER JOIN Cinema c on c.id_cinema=fc.id_cinema
GROUP BY f.nume, g.gen
HAVING  AVG(f.nota)>8


-- returneaza numele cinematografului si nr total de angajati care au experienta mai mare de 3 ani
-- group by, having
SELECT c.nume, COUNT (a.id_angajat) as nr_angajati
FROM Cinema c INNER JOIN Angajat a on c.id_cinema=a.id_cinema
GROUP BY C.nume
HAVING MAX(a.experienta)>3



-- afiseaza numele cinemaului si proiectiile care sunt dupa ora 19
--m-n
SELECT c.nume, p.data_difuzare,p.ora 
FROM Proiectie p, CinemaProiectie cp, Cinema C
WHERE p.ora>19 AND p.id_proiectie=cp.id_proiectie AND cp.id_cinema=c.id_cinema


-- aceasta interogare returneaza un singur film dieferit al unui regizor lansat dupa anul 2000
-- m-n, distinct
SELECT DISTINCT f.regizor , f.nume
FROM Film f, Cinema c, FilmCinema fc
WHERE f.an>2000 AND f.id_film=fc.id_film AND fc.id_cinema=c.id_cinema



--returneaza toate cinema-urile care au pretul abonamentului mai mare de 200, si afiseaza pentru fiecare suma tuturor preturilor si nr de proiectii
-- distinct
--3 Cinema, abonament proiectie
SELECT DISTINCT  c.nume, SUM(DISTINCT a.pret) pret_suma, COUNT(DISTINCT p.id_proiectie) nr_poriectii
FROM Abonament a
INNER JOIN Cinema c on a.id_cinema=c.id_cinema
INNER JOIN CinemaProiectie cp ON cp.id_cinema=c.id_cinema
INNER JOIN Proiectie p on p.id_proiectie=cp.id_cinema 
WHERE a.pret > 200 AND p.ora>15
GROUP BY c.nume
