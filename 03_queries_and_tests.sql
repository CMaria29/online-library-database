--  Managementul comenzilor: selectam numele clientului care a dat o comanda, data comenzii respective si numarul de produse din fiecare comanda
SELECT c.nume, c.prenume, c.email, 
       co.data_comanda,
       COUNT(dc.produs_id) as numar_produse
FROM Client c
JOIN Comanda co ON c.client_id = co.client_id
JOIN Detalii_comanda dc ON co.comanda_id = dc.comanda_id
GROUP BY c.nume, c.prenume, c.email, co.data_comanda, co.status
ORDER BY co.data_comanda DESC;


-- Cerință: Valoarea totală a fiecărei comenzi (suma tuturor produselor din comandă)
SELECT  co.comanda_id,
        co.data_comanda,
        c.nume || ' ' || c.prenume as client,
        co.status,
        COUNT(dc.produs_id) as numar_produse_diferite,
        SUM(dc.cantitate) as total_bucati,
        SUM(p.pret * dc.cantitate) as valoare_totala_comanda
FROM  Comanda co
JOIN Client c ON co.client_id = c.client_id
JOIN Detalii_comanda dc ON co.comanda_id = dc.comanda_id
JOIN Produs p ON p.produs_id = dc.produs_id
GROUP BY co.comanda_id, co.data_comanda, c.nume, c.prenume, co.status
ORDER BY co.comanda_id;

-- Cerință: Managementul informațiilor despre cărți
SELECT  p.produs_id,
        tp.denumire_tip as categorie,
        ca.autor, ca.editura, ca.titlu
FROM  Produs p
JOIN Carte ca ON ca.produs_id=p.produs_id
JOIN Tip_produs tp ON tp.tip_produs_id = p.tip_produs_id 
ORDER BY  ca.titlu;

-- Cerință: Calculează stocul total pentru fiecare furnizor și categorie
SELECT  f.cui,f.nume_firma,
        tp.denumire_tip as categorie,
        SUM(p.stoc) as stoc_per_furnizor_si_categorie
FROM  Furnizor f
JOIN Produs p ON p.furnizor_id=f.furnizor_id
JOIN Tip_produs tp ON tp.tip_produs_id = p.tip_produs_id 
GROUP BY f.nume_firma, f.cui, tp.denumire_tip
ORDER BY  f.nume_firma;

-- Cerință: Gestioneaza feedback-ul oferit de catre clienti
SELECT  p.denumire,
        fb.data_feedback, fb.stele,
        c.nume||' '||c.prenume as Clientul
FROM  Produs p
JOIN Feedback fb ON p.produs_id=fb.produs_id
JOIN Client c ON c.client_id = fb.client_id 
ORDER BY  fb.data_feedback;

-- =============================================
--                  VALIDARI
-- =============================================
-- VALIDARE CLIENT


-- Test PK: client_id unic

    INSERT INTO Client (client_id, nume, email, prenume) VALUES (2, 'Test', 'test1@test.ro', 'Test');
    --Testat: ORA-00001: unique constraint (RO_A285_SQL_S56.CLIENT_PK) violated     ORA-06512: at "SYS.DBMS_SQL", line 1721


-- Test UK: email unic
    INSERT INTO Client (nume, email, prenume) VALUES ('Test', 'ana.popescu@test.com', 'Test');
    --Testat: ORA-02290: check constraint (RO_A285_SQL_S56.CLIENT_EMAIL_CK) violated    ORA-06512: at "SYS.DBMS_SQL", line 1721

-- Test CK: email format corect
    UPDATE Client
    SET email = 'ana.popa'
    WHERE client_id = 6;
    --Testat: ORA-02290: check constraint (RO_A285_SQL_S56.CLIENT_EMAIL_CK) violated    ORA-06512: at "SYS.DBMS_SQL", line 1721

-- Test CK: telefon format corect
    UPDATE Client
    SET telefon = 'an1101'
    WHERE client_id = 6;
    --Testat:ORA-02290: check constraint (RO_A285_SQL_S56.CLIENT_TELEFON_CK) violated   ORA-06512: at "SYS.DBMS_SQL", line 1721
-- Test CK: nume format corect
    UPDATE Client
    SET nume = 'ana11'
    WHERE client_id = 6;
    --Testat:ORA-02290: check constraint (RO_A285_SQL_S56.SYS_C0023666495) violated ORA-06512: at "SYS.DBMS_SQL", line 1721


-- Test NN: nume not null 
    INSERT INTO Client ( email, prenume) VALUES ('ioana.popescu@test.com', 'Test');
    --Testat:ORA-01400: cannot insert NULL into ("RO_A285_SQL_S56"."CLIENT"."NUME") ORA-06512: at "SYS.DBMS_SQL", line 1721

-- VALIDARE FURNIZOR
-- Test PK: furnizor_id unic

    INSERT INTO Furnizor (furnizor_id,nume_firma, cui, telefon, tara, email) 
    VALUES (1,'Creative Pens Inc', '5432109876', '+12125551212', 'Statele Unite ale Americii', 'info@creativepens.us');
    select * from Furnizor;
    --Testat:ORA-00001: unique constraint (RO_A285_SQL_S56.FURNIZOR_PK) violated    ORA-06512: at "SYS.DBMS_SQL", line 1721

-- Test UK: CUI unic
    INSERT INTO Furnizor (nume_firma, cui, telefon, email) 
    VALUES ('Test', '1234567890', '123', 'test2@test.ro');
    --Testat:ORA-00001: unique constraint (RO_A285_SQL_S56.KEY_2V3) violated    ORA-06512: at "SYS.DBMS_SQL", line 1721

-- Test NN: nume not null 
    INSERT INTO Furnizor ( cui, telefon, email) 
    VALUES ( '1238567890', '123', 'test2@test.ro');
    --Testat:ORA-01400: cannot insert NULL into ("RO_A285_SQL_S56"."FURNIZOR"."NUME_FIRMA") ORA-06512: at "SYS.DBMS_SQL", line 1721

-- VALIDARE TIP_PRODUS
-- Test PK: tip_produs_id unic

    INSERT INTO Tip_produs (tip_produs_id, denumire_tip) VALUES (1, 'Test');
    --Testat: ORA-00001: unique constraint (RO_A285_SQL_S56.TIP_PRODUS_PK) violated ORA-06512: at "SYS.DBMS_SQL", line 1721


-- VALIDARE PRODUS
-- Test PK: produs_id unic
    INSERT INTO Produs (produs_id, denumire, pret, stoc, tip_produs_id, furnizor_id) 
    VALUES (2, 'Test PK', 50, 10, 1, 1);
    --Testat: ORA-00001: unique constraint (RO_A285_SQL_S56.PRODUS_PK) violated     ORA-06512: at "SYS.DBMS_SQL", line 1721

-- Test CK: pret > 0
    UPDATE Produs
    SET pret = -10
    WHERE produs_id = 11;
    --Testat:ORA-02290: check constraint (RO_A285_SQL_S56.PRODUS_PRET_CK) violated      ORA-06512: at "SYS.DBMS_SQL", line 1721
-- Test CK: stoc >= 0
    UPDATE Produs
    SET stoc = -10
    WHERE produs_id = 11;
    --Testat:ORA-02290: ORA-02290: check constraint (RO_A285_SQL_S56.PRODUS_STOC_CK) violated ORA-06512: at "SYS.DBMS_SQL", line 1721

-- Test FK: incerc sa sterg un tip de produs in care am deja produse

    DELETE FROM Tip_produs
    WHERE denumire_tip = 'Carti';
    --Testat: ORA-02292: integrity constraint (RO_A285_SQL_S56.PRODUS_FKV2) violated - child record found

-- VALIDARE CARTE
--Test PK: 
    INSERT INTO Carte (autor, editura, isbn, an_publicare, titlu, produs_id)    VALUES ('Autor Test', 'Editura Test', '9999999999', 2024, 'Titlu Duplicat', 11);
    --Testat: ORA-00001: unique constraint (RO_A285_SQL_S56.CARTE_PK) violated ORA-06512: at "SYS.DBMS_SQL", line 1721


-- Test FK: sterg un produs care e si carte

    DELETE FROM Produs
    WHERE produs_id = 11;
    --Testat: ORA-02292: integrity constraint (RO_A285_SQL_S56.FEEDBACK_FKV2) violated - child record found

-- Test CK: ISBN format corect
 
    UPDATE Carte
    SET isbn = 'an1101'
    WHERE produs_id = 11;
    --Testat: ORA-02290: check constraint (RO_A285_SQL_S56.CARTE_ISBN_CK) violated      ORA-06512: at "SYS.DBMS_SQL", line 1721


-- VALIDARE COMANDA

-- Test PK: comanda_id unic

    INSERT INTO Comanda (comanda_id, data_comanda, status, client_id) 
    VALUES (1, DATE '2024-01-01', 'plasata', 1);
   --Testat: ORA-00001: unique constraint (RO_A285_SQL_S56.COMANDA_PK) violated

-- Test CK: status valid
    select * from comanda;
    UPDATE Comanda
    SET status = 'status-invalid'
    WHERE comanda_id = 9;
    --Testat: ORA-02290: check constraint (RO_A285_SQL_S56.COMANDA_STATUS_CK) violated
--Test trigger : Data invalida
    UPDATE Comanda
    SET data_comanda = to_date('11.11.2028','DD.MM.YYYY')
    WHERE comanda_id = 3;
    --Testat: ORA-20001: Data invalida: 11.11.2028 00:00:00 trebuie sa fie mai mica decat data curenta. ORA-06512: at "RO_A285_SQL_S56.TRG_COMANDA_BRIU", line 4

-- Test FK: sterg un client care a dat comenzi

    DELETE FROM Client
    WHERE client_id = 3;
    --Testat: ORA-02292: integrity constraint (RO_A285_SQL_S56.FEEDBACK_FK) violated - child record found


-- VALIDARE FEEDBACK

-- Test PK: feedback_id unic

    INSERT INTO Feedback (feedback_id, stele, data_feedback, client_id, produs_id) 
    VALUES (1, 5, DATE '2024-01-01', 1, 1);
    --Testat: ORA-00001: unique constraint (RO_A285_SQL_S56.FEEDBACK_PK) violated

-- Test CK: stele între 1-5

    UPDATE Feedback
    SET stele = 6
    WHERE feedback_id = 4;
    --Testat: ORA-02290: check constraint (RO_A285_SQL_S56.FEEDBACK_STELE_CK) violated
--Test trigger : Data invalida
    UPDATE Feedback
    SET data_feedback = to_date('11.11.2028','DD.MM.YYYY')
    WHERE feedback_id = 4;
    --Testat: ORA-20001: Data invalida: 11.11.2028 00:00:00 trebuie sa fie mai mica decat data curenta. ORA-06512: at "RO_A285_SQL_S56.TRG_FEEDBACK_BRIU", line 4
-- VALIDARE DETALII_COMANDA

-- Test PK: detalii_id unic

    INSERT INTO Detalii_comanda (detalii_id, cantitate, comanda_id, produs_id) 
    VALUES (1, 2, 1, 1);
    --Testat:ORA-00001: unique constraint (RO_A285_SQL_S56.DETALII_COMANDA_PK) violated     ORA-06512: at "SYS.DBMS_SQL", line 1721


-- Test CK: cantitate > 0
select * from detalii_comanda;
    UPDATE Detalii_comanda
    SET cantitate = 0
    WHERE detalii_id = 3;
    --Testat: ORA-02290: check constraint (RO_A285_SQL_S56.DETALII_COMANDA_CANTITATE_CK) violated

