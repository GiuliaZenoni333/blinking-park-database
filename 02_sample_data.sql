-- Synthetic example records from the original university report.
-- Run after 01_schema.sql. Not independently executed or validated.

INSERT INTO Zona (Nome, AreaCitta, TariffaOraria)
VALUES
    ('Centro', 'Centro storico', 2.50),
    ('Nord', 'Zona nord', 1.50),
    ('Sud', 'Zona sud', 1.20);

INSERT INTO Parcheggio
    (CodParcheggio, Nome, CapacitaComplessiva,
    Tipo, OrarioApertura, NomeZona, AreaCittaZona)
VALUES
    ('P001', 'Garage Roma', 200, 'GARAGE',
    '07:00-23:00', 'Centro', 'Centro storico'),

    ('P002', 'Parcheggio Dora', 150, 'PARCHEGGIO ALL''APERTO',
    NULL, 'Nord', 'Zona nord'),

    ('P003', 'Garage Lingotto', 250, 'GARAGE',
    '06:00-24:00', 'Sud', 'Zona sud');

INSERT INTO Categoria_Veicolo (Nome)
VALUES
    ('AUTO'),
    ('MOTO'),
    ('CAMION');

INSERT INTO Cliente
    (CodiceFiscale, Nome, Cognome, NumeroTelefono, Email)
VALUES
    ('CLNT000000000001', 'Marco', 'Rossi',
     '3331234567', 'marco.rossi@example.com'),

    ('CLNT000000000002', 'Giulia', 'Bianchi',
     '3479876543', 'giulia.bianchi@example.com'),

-- Rappresento anche un cliente senza numero di telefono per rappresentarne l'opzionalità
    ('CLNT000000000003', 'Luca', 'Ferrari',
     NULL, 'luca.ferrari@example.com'),

    ('CLNT000000000004', 'Sara', 'Romano',
     '3204567890', 'sara.romano@example.com');

INSERT INTO Dipendente
    (CodiceFiscale, Nome, Cognome)
VALUES
    ('DIP0000000000001', 'Paolo', 'Verdi'),
    ('DIP0000000000002', 'Anna', 'Gallo'),
    ('DIP0000000000003', 'Davide', 'Moretti'),
    ('DIP0000000000004', 'Elena', 'Ricci'),
    ('DIP0000000000005', 'Matteo', 'Conti');

INSERT INTO Controllore (CFDipendente)
VALUES
    ('DIP0000000000004'), -- associato a Elena Ricci
    ('DIP0000000000005'); -- associato a Matteo Conti

INSERT INTO Operatore
    (CFDipendente, CodParcheggio)
VALUES
    ('DIP0000000000001', 'P001'), -- associato a Paolo Verdi
    ('DIP0000000000002', 'P001'), -- associato a Anna Gallo
    ('DIP0000000000003', 'P003'); -- associato a Davide Moretti

INSERT INTO Capienza
    (CodParcheggio, NomeCategoria, PostiDisponibili, CapacitaPerCategoria)
VALUES
    ('P001', 'AUTO', 120, 120),
    ('P001', 'MOTO', 50, 50),
    ('P001', 'CAMION', 30, 30),

    ('P002', 'AUTO', 110, 110),
    ('P002', 'MOTO', 39, 40),

    ('P003', 'AUTO', 180, 180),
    ('P003', 'MOTO', 70, 70);

INSERT INTO Veicolo
    (Targa, NomeCategoria, CFCliente)
VALUES
    ('AB123CD', 'AUTO', 'CLNT000000000001'),
    ('EF456GH', 'MOTO', 'CLNT000000000001'),
    ('IJ789KL', 'AUTO', 'CLNT000000000002'),
    ('MN321OP', 'CAMION', 'CLNT000000000003'),
    ('QR654ST', 'AUTO', NULL); -- rappresentà opzionalità del possesso

INSERT INTO AbbonamentoAnnuale
    (CodAbbonamento, Tariffa, StatoValidita, DataInizioValidita, CFCliente)
VALUES
    ('A001', 300.00, 'VALIDO', '2026-02-01', 'CLNT000000000001'),
    ('A002', 300.00, 'SCADUTO', '2025-01-15', 'CLNT000000000002'),
    ('A003', 300.00, 'VALIDO', '2026-05-10', 'CLNT000000000004');

INSERT INTO Sosta
    (CodSosta, Data, OraInizio, OraFine, Targa, CodParcheggio, CodAbbonamento, CFControlloreSanzione)
VALUES
    ('S001', '2026-08-20', '08:30', '10:15', 'AB123CD', 'P001', 'A001', NULL),
    ('S002', '2026-08-21', '09:00', '11:00', 'IJ789KL', 'P002', NULL, NULL),
    ('S003', '2026-08-22', '14:00', '16:30', 'IJ789KL', 'P002', NULL, 'DIP0000000000004'),
    ('S004', '2026-08-24', '13:15', NULL, 'EF456GH', 'P002', 'A001', NULL),
    ('S005', '2026-08-23', '10:00', '12:00', 'MN321OP', 'P001', NULL, NULL);

INSERT INTO Biglietto_Singolo
    (CodSosta, StatoValidita, Costo)
VALUES
    ('S002', 'SCADUTO', 3.00),
    ('S003', 'SCADUTO', 3.75),
    ('S005', 'SCADUTO', 5.00);

INSERT INTO Responsabilita
    (CodParcheggio, CFOperatore)
VALUES
    ('P001', 'DIP0000000000001'),
    ('P003', 'DIP0000000000003');

INSERT INTO Sorveglianza
    (CodParcheggio, CFControllore)
VALUES
    ('P002', 'DIP0000000000004'),
    ('P002', 'DIP0000000000005');

INSERT INTO Turno
    (CFControllore, Data, OraInizio, OraFine)
VALUES
    ('DIP0000000000004', '2026-08-22', '08:00', '16:00'),
    ('DIP0000000000004', '2026-08-23', '14:00', '20:00'),
    ('DIP0000000000005', '2026-08-22', '16:00', '22:00'),
    ('DIP0000000000005', '2026-08-24', '08:00', '14:00');

INSERT INTO Valutazione
    (CFCliente, CodParcheggio, Pulizia, Sicurezza)
VALUES
    ('CLNT000000000001', 'P001', 5, 4),
    ('CLNT000000000001', 'P002', 4, 4),
    ('CLNT000000000002', 'P002', 3, 4),
    ('CLNT000000000003', 'P001', 5, 5);

INSERT INTO Sconto
    (CFCliente, Data, NomeZona, AreaCittaZona)
VALUES
    ('CLNT000000000001', '2026-06-01', 'Centro', 'Centro storico'),
    ('CLNT000000000002', '2026-07-15', NULL, NULL),
    ('CLNT000000000004', '2026-08-01', 'Sud', 'Zona sud');
