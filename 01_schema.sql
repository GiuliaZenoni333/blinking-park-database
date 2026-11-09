-- PostgreSQL schema extracted from the original university report.
-- Not independently executed or validated.

CREATE TABLE Zona (
    Nome VARCHAR(30),
    AreaCitta VARCHAR(50),
    TariffaOraria NUMERIC(5,2) NOT NULL CHECK (TariffaOraria >= 0),
    PRIMARY KEY (Nome, AreaCitta)
);

CREATE TABLE Parcheggio (
    CodParcheggio VARCHAR(10),
    Nome VARCHAR(50) NOT NULL,
    CapacitaComplessiva INTEGER NOT NULL CHECK (CapacitaComplessiva >= 0),
    Tipo VARCHAR(30) NOT NULL CHECK (Tipo IN ('GARAGE','PARCHEGGIO ALL''APERTO')),
    OrarioApertura VARCHAR(30),
    NomeZona VARCHAR(30) NOT NULL,
    AreaCittaZona VARCHAR(50) NOT NULL,
    PRIMARY KEY (CodParcheggio),
    FOREIGN KEY (NomeZona, AreaCittaZona)
        REFERENCES Zona(Nome, AreaCitta),
    UNIQUE (Nome, NomeZona, AreaCittaZona),
    CHECK (
        (Tipo = 'GARAGE' AND OrarioApertura IS NOT NULL)
        OR (Tipo = 'PARCHEGGIO ALL''APERTO' AND OrarioApertura IS NULL)
    )
);

CREATE TABLE Categoria_Veicolo (
    Nome VARCHAR(30),
    PRIMARY KEY (Nome)
);

CREATE TABLE Capienza (
    CodParcheggio VARCHAR(10),
    NomeCategoria VARCHAR(30),
    PostiDisponibili INTEGER NOT NULL CHECK (PostiDisponibili >= 0),
    CapacitaPerCategoria INTEGER,
    PRIMARY KEY (CodParcheggio, NomeCategoria),
    FOREIGN KEY (CodParcheggio)
        REFERENCES Parcheggio(CodParcheggio)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (NomeCategoria)
        REFERENCES Categoria_Veicolo(Nome)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CHECK (
        CapacitaPerCategoria IS NULL
        OR (CapacitaPerCategoria >= 0
        AND PostiDisponibili <= CapacitaPerCategoria)
    )
);

CREATE TABLE Cliente (
    CodiceFiscale CHAR(16),
    Nome VARCHAR(30) NOT NULL,
    Cognome VARCHAR(30) NOT NULL,
    NumeroTelefono VARCHAR(20),
    Email VARCHAR(100) NOT NULL,
    PRIMARY KEY (CodiceFiscale)
);

CREATE TABLE Veicolo (
    Targa VARCHAR(10),
    NomeCategoria VARCHAR(30) NOT NULL,
    CFCliente CHAR(16),
    PRIMARY KEY (Targa),
    FOREIGN KEY (NomeCategoria)
        REFERENCES Categoria_Veicolo(Nome),
    FOREIGN KEY (CFCliente)
        REFERENCES Cliente(CodiceFiscale)
);

CREATE TABLE AbbonamentoAnnuale (
    CodAbbonamento VARCHAR(10),
    Tariffa NUMERIC(7,2) NOT NULL CHECK (Tariffa >= 0),
    StatoValidita VARCHAR(10) NOT NULL
        CHECK (StatoValidita IN ('VALIDO','SCADUTO')),
    DataInizioValidita DATE NOT NULL,
    CFCliente CHAR(16) NOT NULL,
    PRIMARY KEY (CodAbbonamento),
    FOREIGN KEY (CFCliente)
        REFERENCES Cliente(CodiceFiscale),
    UNIQUE (CFCliente, DataInizioValidita)
);

CREATE TABLE Dipendente (
    CodiceFiscale CHAR(16),
    Nome VARCHAR(30) NOT NULL,
    Cognome VARCHAR(30) NOT NULL,
    PRIMARY KEY (CodiceFiscale)
);

CREATE TABLE Controllore (
    CFDipendente CHAR(16),
    PRIMARY KEY (CFDipendente),
    FOREIGN KEY (CFDipendente)
        REFERENCES Dipendente(CodiceFiscale)
);

CREATE TABLE Sosta (
    CodSosta VARCHAR(10),
    Data DATE NOT NULL,
    OraInizio TIME NOT NULL,
    OraFine TIME,
    Targa VARCHAR(10) NOT NULL,
    CodParcheggio VARCHAR(10) NOT NULL,
    CodAbbonamento VARCHAR(10),
    CFControlloreSanzione CHAR(16),
    PRIMARY KEY (CodSosta),
    FOREIGN KEY (Targa)
        REFERENCES Veicolo(Targa),
    FOREIGN KEY (CodParcheggio)
        REFERENCES Parcheggio(CodParcheggio),
    FOREIGN KEY (CodAbbonamento)
        REFERENCES AbbonamentoAnnuale(CodAbbonamento),
    FOREIGN KEY (CFControlloreSanzione)
        REFERENCES Controllore(CFDipendente),
    UNIQUE (Targa, Data, OraInizio),
    CHECK (OraFine IS NULL OR OraFine > OraInizio)
);

CREATE TABLE Biglietto_Singolo (
    CodSosta VARCHAR(10),
    StatoValidita VARCHAR(10) NOT NULL
        CHECK (StatoValidita IN ('VALIDO','SCADUTO')),
    Costo NUMERIC(7,2) NOT NULL CHECK (Costo >= 0),
    PRIMARY KEY (CodSosta),
    FOREIGN KEY (CodSosta)
        REFERENCES Sosta(CodSosta)
);

CREATE TABLE Operatore (
    CFDipendente CHAR(16),
    CodParcheggio VARCHAR(10) NOT NULL,
    PRIMARY KEY (CFDipendente),
    FOREIGN KEY (CFDipendente)
        REFERENCES Dipendente(CodiceFiscale),
    FOREIGN KEY (CodParcheggio)
        REFERENCES Parcheggio(CodParcheggio)
);

CREATE TABLE Responsabilita (
    CodParcheggio VARCHAR(10),
    CFOperatore CHAR(16) NOT NULL,
    PRIMARY KEY (CodParcheggio),
    FOREIGN KEY (CodParcheggio)
        REFERENCES Parcheggio(CodParcheggio),
    FOREIGN KEY (CFOperatore)
        REFERENCES Operatore(CFDipendente),
    UNIQUE (CFOperatore)
);

CREATE TABLE Sorveglianza (
    CodParcheggio VARCHAR(10),
    CFControllore CHAR(16),
    PRIMARY KEY (CodParcheggio, CFControllore),
    FOREIGN KEY (CodParcheggio)
        REFERENCES Parcheggio(CodParcheggio),
    FOREIGN KEY (CFControllore)
        REFERENCES Controllore(CFDipendente)
);

CREATE TABLE Turno (
    CFControllore CHAR(16),
    Data DATE,
    OraInizio TIME,
    OraFine TIME NOT NULL,
    PRIMARY KEY (CFControllore, Data, OraInizio),
    FOREIGN KEY (CFControllore)
        REFERENCES Controllore(CFDipendente),
    CHECK (OraFine > OraInizio)
);

CREATE TABLE Valutazione (
    CFCliente CHAR(16),
    CodParcheggio VARCHAR(10),
    Pulizia INTEGER NOT NULL,
    Sicurezza INTEGER NOT NULL,
    PRIMARY KEY (CFCliente, CodParcheggio),
    FOREIGN KEY (CFCliente)
        REFERENCES Cliente(CodiceFiscale),
    FOREIGN KEY (CodParcheggio)
        REFERENCES Parcheggio(CodParcheggio)
);

CREATE TABLE Sconto (
    CFCliente CHAR(16),
    Data DATE,
    NomeZona VARCHAR(30),
    AreaCittaZona VARCHAR(50),
    PRIMARY KEY (CFCliente, Data),
    FOREIGN KEY (CFCliente)
        REFERENCES Cliente(CodiceFiscale),
    FOREIGN KEY (NomeZona, AreaCittaZona)
        REFERENCES Zona(Nome, AreaCitta),
    CHECK (
        (NomeZona IS NULL AND AreaCittaZona IS NULL)
        OR (NomeZona IS NOT NULL AND AreaCittaZona IS NOT NULL)
    )
);
