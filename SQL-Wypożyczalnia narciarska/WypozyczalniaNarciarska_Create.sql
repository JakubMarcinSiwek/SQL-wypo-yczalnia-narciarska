-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-07-03 22:54:59.669

-- tables
-- Table: Cennik
CREATE TABLE Cennik (
    IdUslugi integer  NOT NULL,
    NazwaUslugi varchar2(30)  NOT NULL,
    Cena integer  NOT NULL,
    CONSTRAINT Cennik_pk PRIMARY KEY (IdUslugi)
) ;

-- Table: Firmy
CREATE TABLE Firmy (
    Nazwa varchar2(20)  NOT NULL,
    CONSTRAINT Firmy_pk PRIMARY KEY (Nazwa)
) ;

-- Table: Klient
CREATE TABLE Klient (
    IdKlient integer  NOT NULL,
    CONSTRAINT Klient_pk PRIMARY KEY (IdKlient)
) ;

-- Table: KlientWypozycza
CREATE TABLE KlientWypozycza (
    IdWypozyczenia integer  NOT NULL,
    DataWypozyczenia date  NOT NULL,
    DataZwrotu date  NULL,
    IdKlient integer  NOT NULL,
    IdPracownik integer  NOT NULL,
    CONSTRAINT KlientWypozycza_pk PRIMARY KEY (IdWypozyczenia)
) ;

-- Table: Osoba
CREATE TABLE Osoba (
    IdOsoby integer  NOT NULL,
    Imie varchar2(15)  NOT NULL,
    Nazwisko varchar2(15)  NOT NULL,
    Waga integer  NOT NULL,
    Adres varchar2(20)  NOT NULL,
    CONSTRAINT Osoba_pk PRIMARY KEY (IdOsoby)
) ;

-- Table: Pracownik
CREATE TABLE Pracownik (
    DataZatrudnienia date  NOT NULL,
    IdPracownik integer  NOT NULL,
    CONSTRAINT Pracownik_pk PRIMARY KEY (IdPracownik)
) ;

-- Table: SerwisNart
CREATE TABLE SerwisNart (
    IdFaktuSerwisu integer  NOT NULL,
    IdUslugi integer  NOT NULL,
    IdPracownik integer  NOT NULL,
    IdSprzetuKlienta integer  NULL,
    IdSprzetuFirmy integer  NULL,
    CONSTRAINT SerwisNart_pk PRIMARY KEY (IdFaktuSerwisu)
) ;

-- Table: SprzetDoWypozyczenia
CREATE TABLE SprzetDoWypozyczenia (
    IdSprzetuFirmy integer  NOT NULL,
    Rodzaj varchar2(30)  NOT NULL,
    Firma varchar2(20)  NOT NULL,
    CONSTRAINT SprzetDoWypozyczenia_pk PRIMARY KEY (IdSprzetuFirmy)
) ;

-- Table: SprzetKlienta
CREATE TABLE SprzetKlienta (
    IdSprzetu integer  NOT NULL,
    IdKlient integer  NOT NULL,
    DlugoscNarty integer  NOT NULL,
    SzerokoscNarty integer  NOT NULL,
    StanNarty varchar2(20)  NOT NULL,
    Firma varchar2(20)  NOT NULL,
    CONSTRAINT SprzetKlienta_pk PRIMARY KEY (IdSprzetu)
) ;

-- Table: SprzetWypozyczony
CREATE TABLE SprzetWypozyczony (
    IdSprzetuFirmy integer  NOT NULL,
    IdWypozyczenia integer  NOT NULL,
    CONSTRAINT SprzetWypozyczony_pk PRIMARY KEY (IdSprzetuFirmy,IdWypozyczenia)
) ;

-- foreign keys
-- Reference: KlientWypozycza_Klient (table: KlientWypozycza)
ALTER TABLE KlientWypozycza ADD CONSTRAINT KlientWypozycza_Klient
    FOREIGN KEY (IdKlient)
    REFERENCES Klient (IdKlient);

-- Reference: KlientWypozycza_Pracownik (table: KlientWypozycza)
ALTER TABLE KlientWypozycza ADD CONSTRAINT KlientWypozycza_Pracownik
    FOREIGN KEY (IdPracownik)
    REFERENCES Pracownik (IdPracownik);

-- Reference: Klient_Osoba (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_Osoba
    FOREIGN KEY (IdKlient)
    REFERENCES Osoba (IdOsoby);

-- Reference: Pracownik_Osoba (table: Pracownik)
ALTER TABLE Pracownik ADD CONSTRAINT Pracownik_Osoba
    FOREIGN KEY (IdPracownik)
    REFERENCES Osoba (IdOsoby);

-- Reference: SerwisNart_Cennik (table: SerwisNart)
ALTER TABLE SerwisNart ADD CONSTRAINT SerwisNart_Cennik
    FOREIGN KEY (IdUslugi)
    REFERENCES Cennik (IdUslugi);

-- Reference: SerwisNart_Pracownik (table: SerwisNart)
ALTER TABLE SerwisNart ADD CONSTRAINT SerwisNart_Pracownik
    FOREIGN KEY (IdPracownik)
    REFERENCES Pracownik (IdPracownik);

-- Reference: SerwisNart_SprzetKlienta (table: SerwisNart)
ALTER TABLE SerwisNart ADD CONSTRAINT SerwisNart_SprzetKlienta
    FOREIGN KEY (IdSprzetuKlienta)
    REFERENCES SprzetKlienta (IdSprzetu);

-- Reference: SprzetDoWypozyczenia (table: SerwisNart)
ALTER TABLE SerwisNart ADD CONSTRAINT SprzetDoWypozyczenia
    FOREIGN KEY (IdSprzetuFirmy)
    REFERENCES SprzetDoWypozyczenia (IdSprzetuFirmy);

-- Reference: SprzetDoWypozyczenia_Firmy (table: SprzetDoWypozyczenia)
ALTER TABLE SprzetDoWypozyczenia ADD CONSTRAINT SprzetDoWypozyczenia_Firmy
    FOREIGN KEY (Firma)
    REFERENCES Firmy (Nazwa);

-- Reference: SprzetKlienta_Firmy (table: SprzetKlienta)
ALTER TABLE SprzetKlienta ADD CONSTRAINT SprzetKlienta_Firmy
    FOREIGN KEY (Firma)
    REFERENCES Firmy (Nazwa);

-- Reference: SprzetKlienta_Klient (table: SprzetKlienta)
ALTER TABLE SprzetKlienta ADD CONSTRAINT SprzetKlienta_Klient
    FOREIGN KEY (IdKlient)
    REFERENCES Klient (IdKlient);

-- Reference: Table_18_KlientWypozycza (table: SprzetWypozyczony)
ALTER TABLE SprzetWypozyczony ADD CONSTRAINT Table_18_KlientWypozycza
    FOREIGN KEY (IdWypozyczenia)
    REFERENCES KlientWypozycza (IdWypozyczenia);

-- Reference: Table_18_SprzetDoWypozyczenia (table: SprzetWypozyczony)
ALTER TABLE SprzetWypozyczony ADD CONSTRAINT Table_18_SprzetDoWypozyczenia
    FOREIGN KEY (IdSprzetuFirmy)
    REFERENCES SprzetDoWypozyczenia (IdSprzetuFirmy);

-- End of file.

