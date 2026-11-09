-- Integrity tests from the original university report.
-- Some tests intentionally raise database errors; execute individually.
-- Not independently executed or validated.

-- Test 1: modifica valida dei posti disponibili
-- 119 non supera la capacità prevista per AUTO (120)
UPDATE Capienza
SET PostiDisponibili = 119
WHERE CodParcheggio = 'P001'
AND NomeCategoria = 'AUTO';

SELECT *
FROM Capienza
WHERE CodParcheggio = 'P001'
AND NomeCategoria = 'AUTO';

-- Test 2: verifica del vincolo CHECK sulla capienza
-- 150 posti disponibili superano la capacità di AUTO
UPDATE Capienza
SET PostiDisponibili = 150
WHERE CodParcheggio = 'P001'
AND NomeCategoria = 'AUTO';

-- Test 3: Delete bloccata da una FK
-- Il cliente non viene eliminato perchè è referenziato ancora da altre tabelle
DELETE FROM Cliente
WHERE CodiceFiscale = 'CLNT000000000001';

-- Test 4: verifica di ON UPDATE CASCADE e ON DELETE CASCADE
-- Controllo che la modifica e la cancellazione della chiave di Parcheggio vengano
-- propagate automaticmanete a Capienza
INSERT INTO Parcheggio
    (CodParcheggio, Nome, CapacitaComplessiva, Tipo, OrarioApertura, NomeZona, AreaCittaZona)
VALUES
    ('PTEST', 'Parcheggio Test', 10, 'PARCHEGGIO ALL''APERTO',
    NULL, 'Nord', 'Zona nord');

INSERT INTO Capienza
    (CodParcheggio, NomeCategoria, PostiDisponibili, CapacitaPerCategoria)
VALUES
    ('PTEST', 'AUTO', 10, 10);

-- Modifico chiave di Parcheggio
UPDATE Parcheggio
SET CodParcheggio = 'PTEST2'
WHERE CodParcheggio = 'PTEST';

SELECT *
FROM Capienza
WHERE CodParcheggio = 'PTEST2';

-- Cancellazione di Parcheggio
DELETE FROM Parcheggio
WHERE CodParcheggio = 'PTEST2';

SELECT *
FROM Capienza
WHERE CodParcheggio = 'PTEST2';

-- Ripristino del valore iniziale dopo i test
UPDATE Capienza
SET PostiDisponibili = 120
WHERE CodParcheggio = 'P001'
AND NomeCategoria = 'AUTO';
