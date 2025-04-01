
-- ************************************************** WSTAWIANIE *******************************************************

-- Wstawianie danych do tabeli Wykladowcy
INSERT INTO Wykladowcy (pesel, imie, nazwisko, stopien_naukowy, data_zatrudnienia)
VALUES ('12345678901', 'Jan', 'Kowalski', 'Doktor', TO_DATE('2015-09-01', 'YYYY-MM-DD'));
INSERT INTO Wykladowcy (pesel, imie, nazwisko, stopien_naukowy, data_zatrudnienia)
VALUES ('98765432109', 'Anna', 'Nowak', 'Profesor', TO_DATE('2010-02-15', 'YYYY-MM-DD'));

-- Wstawianie danych do tabeli KolaNaukowe
INSERT INTO KolaNaukowe (nazwa, opiekun)
VALUES ('Koło Programistów', 'Jan Kowalski');
INSERT INTO KolaNaukowe (nazwa, opiekun)
VALUES ('Koło Robotyki', 'Anna Nowak');

-- Wstawianie danych do tabeli Kierunki
INSERT INTO Kierunki (nazwa, typ, rok_rozpoczecia, stopien, wydzial)
VALUES ('Informatyka', 'dzienne', TO_DATE('2020-09-01', 'YYYY-MM-DD'), 'magister', 'Wydział Informatyki');
INSERT INTO Kierunki (nazwa, typ, rok_rozpoczecia, stopien, wydzial)
VALUES ('Robotyka', 'zaoczne', TO_DATE('2019-09-01', 'YYYY-MM-DD'), 'inżynier', 'Wydział Mechaniczny');

-- Wstawianie danych do tabeli Zajecia
INSERT INTO Zajecia (dzien_tygodnia, godzina, sala, typ, pesel, nazwa, nazwa_kierunku, typ_przedmiotu, rok_rozpoczecia, stopien)
VALUES ('Wtorek', TO_DATE('10:00', 'HH24:MI'), '101', 'wykład', '12345678901', 'Algorytmy i Struktury Danych', 'Informatyka', 'dzienne', TO_DATE('2020-09-01', 'YYYY-MM-DD'), 'magister');
INSERT INTO Zajecia (dzien_tygodnia, godzina, sala, typ, pesel, nazwa, nazwa_kierunku, typ_przedmiotu, rok_rozpoczecia, stopien)
VALUES ('Środa', TO_DATE('14:00', 'HH24:MI'), '202', 'laboratorium', '98765432109', 'Podstawy Robotyki','Robotyka', 'zaoczne', TO_DATE('2019-09-01', 'YYYY-MM-DD'), 'inżynier');

-- Wstawianie danych do tabeli Przedmioty
INSERT INTO Przedmioty (nazwa, ilosc_godzin, nazwa_kierunku, typ, rok_rozpoczecia, stopien)
VALUES ('Algorytmy i Struktury Danych', 60, 'Informatyka', 'dzienne', TO_DATE('2020-09-01', 'YYYY-MM-DD'), 'magister');
INSERT INTO Przedmioty (nazwa, ilosc_godzin, nazwa_kierunku, typ, rok_rozpoczecia, stopien)
VALUES ('Podstawy Robotyki', 45, 'Robotyka', 'zaoczne', TO_DATE('2019-09-01', 'YYYY-MM-DD'), 'inżynier');

-- Wstawianie danych do tabeli Studenci
INSERT INTO Studenci (pesel, imie, nazwisko, miejsce_zamieszkania)
VALUES ('11111111111', 'Piotr', 'Zielinski', 'Warszawa');
INSERT INTO Studenci (pesel, imie, nazwisko, miejsce_zamieszkania)
VALUES ('22222222222', 'Katarzyna', 'Kowalska', 'Kraków');

-- Wstawianie danych do tabeli Czlonkowstwo
INSERT INTO Czlonkowstwa (rola, od, do, nazwa, pesel)
VALUES ('członek', TO_DATE('2021-10-01', 'YYYY-MM-DD'), TO_DATE('2022-06-30', 'YYYY-MM-DD'), 'Koło Programistów', '11111111111');
INSERT INTO Czlonkowstwa (rola, od, do, nazwa, pesel)
VALUES ('przewodniczący', TO_DATE('2020-09-01', 'YYYY-MM-DD'), TO_DATE('2021-09-01', 'YYYY-MM-DD'), 'Koło Robotyki', '22222222222');

-- Wstawianie danych do tabeli Stypendium
INSERT INTO Stypendia (typ, data_przyznania, data_zakonczenia, kwota, pesel)
VALUES ('socjalne', TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2022-06-30', 'YYYY-MM-DD'), 1500, '11111111111');
INSERT INTO Stypendia (typ, data_przyznania, data_zakonczenia, kwota, pesel)
VALUES ('rektora', TO_DATE('2021-10-01', 'YYYY-MM-DD'), TO_DATE('2022-06-30', 'YYYY-MM-DD'), 2000, '22222222222');

-- Wstawianie danych do tabeli Ocena
INSERT INTO Oceny (numer, ocena, data, pesel, nazwa_przedmiotu, nazwa_kierunku, typ, rok_rozpoczecia, stopien)
VALUES (1, 5, TO_DATE('2024-06-15', 'YYYY-MM-DD'), '11111111111', 'Algorytmy i Struktury Danych', 'Informatyka', 'dzienne', TO_DATE('2020-09-01', 'YYYY-MM-DD'), 'magister');
INSERT INTO Oceny (numer, ocena, data, pesel, nazwa_przedmiotu, nazwa_kierunku, typ, rok_rozpoczecia, stopien)
VALUES (2, 4, TO_DATE('2024-06-15', 'YYYY-MM-DD'), '22222222222', 'Podstawy Robotyki', 'Robotyka', 'zaoczne', TO_DATE('2019-09-01', 'YYYY-MM-DD'), 'inżynier');



-- **************************** PRZYKLADOWE SELECTY****************************
select dzien_tygodnia, TO_CHAR(godzina, 'HH24:MI') as godzina from zajecia where godzina < TO_DATE('15:00', 'HH24:MI'); --np w jakie dni są zajęcia przed 15:00

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
