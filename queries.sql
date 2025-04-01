
-- **************************** PRZYKLADOWE SELECTY****************************
select dzien_tygodnia, TO_CHAR(godzina, 'HH24:MI') as godzina from zajecia where godzina < TO_DATE('15:00', 'HH24:MI'); 

select o.numer, o.ocena, o.data, s.imie, s.nazwisko from oceny o INNER JOIN studenci s on o.pesel = s.pesel;

select count(*) as ile_osob_ponizej_2000 from stypendia where kwota < 2000;


-- *************************** PRZYKLADOWE UPDATE'Y ************************************************
UPDATE przedmioty
set ilosc_godzin = LOWER(ilosc_godzin / 2);

UPDATE oceny
set ocena = (CASE
when stopien = 'inżynier' then 5
when stopien = 'magister' then 4
else 2
end);

-- ***************************************************** TEST ZŁEGO WSTAWIANIA ***************************************
INSERT INTO Kierunki (nazwa, typ, rok_rozpoczecia, stopien, wydzial)
VALUES ('Robotyka', 'zaoczne', TO_DATE('2019-09-01', 'YYYY-MM-DD'), 'inrzynier', 'Wydział Mechaniczny');

INSERT INTO Oceny (numer, ocena, data, pesel, nazwa_przedmiotu, nazwa_kierunku, typ, rok_rozpoczecia, stopien)
VALUES (1, 8, TO_DATE('2024-06-15', 'YYYY-MM-DD'), '11111111111', 'Algorytmy i Struktury Danych', 'Informatyka', 'dzienne', TO_DATE('2020-09-01', 'YYYY-MM-DD'), 'magister');
