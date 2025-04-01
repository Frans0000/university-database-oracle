-- Tworzenie tabeli Wykladowcy
CREATE TABLE Wykladowcy (
    pesel CHAR(11) NOT NULL,
    imie VARCHAR2(50) NOT NULL,
    nazwisko VARCHAR2(50) NOT NULL,
    stopien_naukowy VARCHAR2(50) NOT NULL,
    data_zatrudnienia DATE NOT NULL,
    
    CONSTRAINT pk_wykladowcy PRIMARY KEY (pesel),
    CONSTRAINT chk_stopien CHECK(stopien_naukowy IN ('Doktor','Profesor', 'Magister')),
    CONSTRAINT chk_data CHECK(data_zatrudnienia > TO_DATE('01-01-1950', 'dd-mm-yyyy'))
);

-- Tworzenie tabeli KolaNaukowe
CREATE TABLE KolaNaukowe (
    nazwa VARCHAR2(50) NOT NULL,
    opiekun VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_kola_naukowe PRIMARY KEY (nazwa)
);

-- Tworzenie tabeli Kierunki
CREATE TABLE Kierunki (
    nazwa VARCHAR2(50) NOT NULL,
    typ VARCHAR2(50) NOT NULL,
    rok_rozpoczecia DATE NOT NULL,
    stopien VARCHAR2(50) NOT NULL,
    wydzial VARCHAR2(50),
    CONSTRAINT chk_stopien_kierunek CHECK(stopien IN ('magister','inżynier','doktor')),
    CONSTRAINT pk_kierunki PRIMARY KEY (nazwa, typ, rok_rozpoczecia, stopien),
    CONSTRAINT uk_nazwa UNIQUE(nazwa),
    CONSTRAINT chk_typ CHECK(typ in ('dzienne', 'zaoczne', 'wieczorowe')),
    CONSTRAINT chk_rok CHECK(rok_rozpoczecia > TO_DATE('01-01-2000','dd-mm-yyyy'))
);

-- Tworzenie tabeli Zajecia
CREATE TABLE Zajecia (
    dzien_tygodnia VARCHAR2(12) NOT NULL,
    godzina DATE NOT NULL,
    sala VARCHAR2(5) NOT NULL,
    typ VARCHAR2(15) NOT NULL,
    pesel CHAR(11) NOT NULL,
    nazwa VARCHAR(50) NOT NULL,
    nazwa_kierunku VARCHAR2(50) NOT NULL,
    typ_przedmiotu VARCHAR2(50) NOT NULL,
    rok_rozpoczecia DATE NOT NULL,
    stopien VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_zajecia PRIMARY KEY (dzien_tygodnia, godzina, sala, typ, pesel, nazwa, nazwa_kierunku, typ_przedmiotu, rok_rozpoczecia, stopien),
    CONSTRAINT chk_typ_zajecia CHECK(typ IN ('wykład', 'laboratorium', 'ćwiczenia')),
	CONSTRAINT fk_wykladowcy FOREIGN KEY (pesel) REFERENCES Wykladowcy (pesel), 
    CONSTRAINT fk_przedmioty FOREIGN KEY (nazwa, nazwa_kierunku, typ_przedmiotu, rok_rozpoczecia, stopien) REFERENCES Przedmioty(nazwa, nazwa_kierunku, typ, rok_rozpoczecia, stopien)
);

-- Tworzenie tabeli Przedmioty
CREATE TABLE Przedmioty (
    nazwa VARCHAR2(50) NOT NULL,
    ilosc_godzin NUMBER(2) NOT NULL,
    nazwa_kierunku VARCHAR2(50) NOT NULL,
    typ VARCHAR2(50) NOT NULL,
    rok_rozpoczecia DATE NOT NULL,
    stopien VARCHAR2(50) NOT NULL,
    CONSTRAINT chk_godziny CHECK(ilosc_godzin < 65),
    CONSTRAINT pk_przedmioty PRIMARY KEY (nazwa, nazwa_kierunku, typ, rok_rozpoczecia, stopien),
    CONSTRAINT fk_przedmioty_kierunki FOREIGN KEY (nazwa_kierunku, typ, rok_rozpoczecia, stopien)
    REFERENCES Kierunki (nazwa, typ, rok_rozpoczecia, stopien)
);


-- Tworzenie tabeli Studenci
CREATE TABLE Studenci (
    pesel CHAR(11) NOT NULL,
    imie VARCHAR2(50) NOT NULL,
    nazwisko VARCHAR2(50) NOT NULL,
    miejsce_zamieszkania VARCHAR2(50),
    CONSTRAINT pk_studenci PRIMARY KEY (pesel)
);

-- Tworzenie tabeli Czlonkowstwa
CREATE TABLE Czlonkowstwa (
    rola VARCHAR2(50),
    od DATE,
    do DATE,
    nazwa VARCHAR2(50) NOT NULL,
    pesel CHAR(11) NOT NULL,
    CONSTRAINT chk_rola CHECK(rola IN ('członek','przewodniczący', 'opiekun')),
    CONSTRAINT pk_czlonkowstwo PRIMARY KEY (nazwa, pesel),
    CONSTRAINT fk_czlonkowstwo_kola FOREIGN KEY (nazwa) REFERENCES KolaNaukowe (nazwa),
    CONSTRAINT fk_czlonkowstwo_studenci FOREIGN KEY (pesel) REFERENCES Studenci (pesel)
);


-- Tworzenie tabeli Stypendia
CREATE TABLE Stypendia (
    typ VARCHAR2(50) NOT NULL,
    data_przyznania DATE NOT NULL,
    data_zakonczenia DATE NOT NULL,
    kwota NUMBER(4) NOT NULL,
    pesel CHAR(11) NOT NULL,
    CONSTRAINT chk_typ_stypendium CHECK(typ IN ('rektora','wojewody', 'socjalne')),
    CONSTRAINT chk_kwota CHECK(kwota > 0 AND kwota < 5000),
    CONSTRAINT pk_stypendium PRIMARY KEY (typ, data_przyznania, pesel),
    CONSTRAINT fk_stypendium_studenci FOREIGN KEY (pesel) REFERENCES Studenci (pesel)
);


-- Tworzenie tabeli Oceny
CREATE TABLE Oceny (
    numer NUMBER(2) NOT NULL,
    ocena NUMBER(1) NOT NULL,
    data DATE NOT NULL,
    pesel CHAR(11) NOT NULL,
    nazwa_przedmiotu VARCHAR2(50) NOT NULL,
    nazwa_kierunku VARCHAR2(50) NOT NULL,
    typ VARCHAR2(50) NOT NULL,
    rok_rozpoczecia DATE NOT NULL,
    stopien VARCHAR2(50) NOT NULL,
    CONSTRAINT chk_ocena CHECK(ocena > 1 AND ocena < 6),
    --CONSTRAINT chk_data_oceny CHECK(data <= CURRENT_DATE),
    CONSTRAINT pk_ocena PRIMARY KEY (numer, pesel, nazwa_przedmiotu),
    CONSTRAINT fk_ocena_studenci FOREIGN KEY (pesel) REFERENCES Studenci (pesel),
    CONSTRAINT fk_ocena_przedmioty FOREIGN KEY (nazwa_przedmiotu, nazwa_kierunku, typ, rok_rozpoczecia, stopien)
    REFERENCES Przedmioty (nazwa, nazwa_kierunku, typ, rok_rozpoczecia, stopien)
);

-- ************************ przyklady **********************

-- select table_name from user_tables;

-- ALTER TABLE oceny DISABLE CONSTRAINT chk_ocena;

-- ALTER TABLE oceny ENABLE CONSTRAINT chk_ocena;

-- DROP TABLE Czlonkowstwa CASCADE CONSTRAINTS;
