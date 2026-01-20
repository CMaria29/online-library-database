-- inserare tipuri produse
INSERT INTO Tip_produs (denumire_tip) VALUES ('Carti');
INSERT INTO Tip_produs (denumire_tip) VALUES ('Articole de papetarie');
INSERT INTO Tip_produs (denumire_tip) VALUES ('Echipamente IT');
INSERT INTO Tip_produs (denumire_tip) VALUES ('Jocuri de societate');
INSERT INTO Tip_produs (denumire_tip) VALUES ('Articole de Birou');
select * from Tip_produs;

-- inserare furnizori

INSERT INTO Furnizor (nume_firma, cui, telefon, tara, email) VALUES ('Editura Minerva', '1234567890', '+40722111222', 'Romania', 'minerva@editura.ro');
INSERT INTO Furnizor (nume_firma, cui, telefon, tara, email) VALUES ('Global Tech LTD', '0987654321', '0044712345678', 'Marea Britanie', 'support@globaltech.com');
INSERT INTO Furnizor (nume_firma, cui, telefon, tara, email) VALUES ('Papyrus Office', '1122334455', '+34915556677', 'Spania', 'sales@papyrus-office.es');
INSERT INTO Furnizor (nume_firma, cui, telefon, tara, email) VALUES ('BoardGame Masters', '6789012345', '+493099887766', 'Germania', 'contact@bgm.de');
INSERT INTO Furnizor (nume_firma, cui, telefon, tara, email) VALUES ('Creative Pens Inc', '5432109876', '+12125551212', 'Statele Unite ale Americii', 'info@creativepens.us');
select * from Furnizor;

--inserare produse
INSERT INTO Produs (denumire, pret, stoc, descriere, tip_produs_id, furnizor_id) 
VALUES ('Stilou Pilot', 120, 500, 'Stilou metalic de lux', (SELECT tip_produs_id FROM Tip_produs WHERE denumire_tip = 'Articole de papetarie'),(SELECT furnizor_id FROM Furnizor WHERE cui = '5432109876') );

INSERT INTO Produs (denumire, pret, stoc, descriere, tip_produs_id, furnizor_id) 
VALUES ('Mouse Wireless Ergonomic', 250, 150, 'Mouse vertical, reincarcabil', (SELECT tip_produs_id FROM Tip_produs WHERE denumire_tip = 'Echipamente IT'),(SELECT furnizor_id FROM Furnizor WHERE cui = '0987654321') );

INSERT INTO Produs (denumire, pret, stoc, descriere, tip_produs_id, furnizor_id)
VALUES ('Carnet Linii', 35, 500, '80 de foi, coperta cartonata', (SELECT tip_produs_id FROM Tip_produs WHERE denumire_tip = 'Articole de papetarie'),(SELECT furnizor_id FROM Furnizor WHERE cui = '1122334455') );

INSERT INTO Produs (denumire, pret, stoc, descriere, tip_produs_id, furnizor_id) 
VALUES ('Joc Alias Clasic', 180, 80, 'Joc de societate, distractiv', (SELECT tip_produs_id FROM Tip_produs WHERE denumire_tip = 'Jocuri de societate'), (SELECT furnizor_id FROM Furnizor WHERE cui = '6789012345') );

INSERT INTO Produs (denumire, pret, stoc, descriere, tip_produs_id, furnizor_id)
VALUES ('Suport Ergonomic Monitor', 95, 200, 'Metal, ajustabil pe inaltime', (SELECT tip_produs_id FROM Tip_produs WHERE denumire_tip = 'Articole de Birou'), (SELECT furnizor_id FROM Furnizor WHERE cui = '0987654321') );
select * from Produs order by produs_id;  ---am dat de 3 ori pe insert produs carnet linii (de asta a crescut id ul)

--produse carti
INSERT INTO Produs ( denumire, pret, stoc, descriere, tip_produs_id, furnizor_id) VALUES ( 'O mie noua sute optzeci si patru', 45, 120, 'Roman distopic celebru.', 1, 1);

-- Produs 2: 'Sa ucizi o pasare cantatoare'
INSERT INTO Produs ( denumire, pret, stoc, descriere, tip_produs_id, furnizor_id) VALUES ( 'Sa ucizi o pasare cantatoare ', 40, 90, 'Clasic al literaturii americane.', 1, 1);

-- Produs 3: 'Ion'
INSERT INTO Produs ( denumire, pret, stoc, descriere, tip_produs_id, furnizor_id) VALUES ('Ion', 30, 150, 'Roman interbelic romanesc.', 1, 1);

-- Produs 4: 'Crima si pedeapsa'
INSERT INTO Produs ( denumire, pret, stoc, descriere, tip_produs_id, furnizor_id) VALUES ( 'Crima si pedeapsa', 60, 85, 'Capodopera a literaturii ruse.', 1, 1);

-- Produs 5: 'Un veac de singuratate'
INSERT INTO Produs ( denumire, pret, stoc, descriere, tip_produs_id, furnizor_id)  VALUES ('Un veac de singuratate', 55, 110, 'Realism magic latino-american.', 1, 1);



--inserare carte

INSERT INTO Carte (produs_id, autor, editura, isbn, an_publicare, titlu) VALUES (10, 'George Orwell', 'Leda', '9786067008779', 1949, 'O mie noua sute optzeci si patru');
INSERT INTO Carte (produs_id, autor, editura, isbn, an_publicare, titlu) VALUES (11, 'Harper Lee', 'Polirom', '9789736817105', 1960, 'Sa ucizi o pasare cantatoare');
INSERT INTO Carte (produs_id, autor, editura, isbn, an_publicare, titlu) VALUES (12, 'Liviu Rebreanu', 'Humanitas', '9786067784301', 1920, 'Ion');
INSERT INTO Carte (produs_id, autor, editura, isbn, an_publicare, titlu) VALUES (13, 'Fyodor Dostoevsky', 'Art', '9786067000000', 1866, 'Crima si pedeapsa');
INSERT INTO Carte (produs_id, autor, editura, isbn, an_publicare, titlu) VALUES (14, 'Gabriel Garcia-Marquez', 'RAO', '9786066000001', 1967, 'Un veac de singuratate');

--inserare client

INSERT INTO Client (nume, prenume, email, telefon, adresa) VALUES ('Popescu', 'Maria', 'ana.popescu@test.com', '+40744123456', 'Strada Zambilei, nr. 10, Bucuresti');
INSERT INTO Client (nume, prenume, email, telefon, adresa) VALUES ('Ionescu', 'Radu', 'radu.ionescu@test.ro', '0722987654', 'Bulevardul Libertatii 50, Cluj');
INSERT INTO Client (nume, prenume, email, telefon, adresa) VALUES ('Georgescu', 'Mihai', 'mihai.georgescu@fake.eu', '+40317778899', 'Strada Muncii nr. 1, bloc C3, Iasi');
INSERT INTO Client (nume, prenume, email, telefon, adresa) VALUES ('Vasile', 'Elena', 'elena.vasile@test.net', '0760111222', 'Aleea Nucului, nr. 22A, Timisoara');
INSERT INTO Client (nume, prenume, email, telefon, adresa) VALUES ('Sandu', 'Costin', 'costin.sandu@mail.com', '+40214567890', 'Piata Unirii, nr. 1, Oradea');
select * from Client order by client_id; 
-- inserare comanda

INSERT INTO Comanda (data_comanda, status, client_id) VALUES (DATE '2025-11-20', 'livrata',  (SELECT client_id FROM Client WHERE email = 'ana.popescu@test.com'));
INSERT INTO Comanda (data_comanda, status, client_id) VALUES (DATE '2025-11-22', 'in curs de livrare',  (SELECT client_id FROM Client WHERE email = 'radu.ionescu@test.ro'));
INSERT INTO Comanda (data_comanda, status, client_id) VALUES (DATE '2025-11-25', 'plasata',  (SELECT client_id FROM Client WHERE email = 'mihai.georgescu@fake.eu'));
INSERT INTO Comanda (data_comanda, status, client_id) VALUES (DATE '2025-11-15', 'livrata',  (SELECT client_id FROM Client WHERE email = 'elena.vasile@test.net'));
INSERT INTO Comanda (data_comanda, status, client_id) VALUES (SYSDATE, 'plasata',  (SELECT client_id FROM Client WHERE email = 'costin.sandu@mail.com'));
INSERT INTO Comanda ( data_comanda, status, client_id)VALUES ( DATE '2025-11-20', 'livrata',  (SELECT client_id FROM Client WHERE email = 'ana.popescu@test.com'));
INSERT INTO Comanda (data_comanda, status, client_id) VALUES ( DATE '2025-11-23', 'in curs de livrare',  (SELECT client_id FROM Client WHERE email = 'ana.popescu@test.com'));
INSERT INTO Comanda (data_comanda, status, client_id) VALUES ( SYSDATE, 'plasata',  (SELECT client_id FROM Client WHERE email = 'radu.ionescu@test.ro'));
select * from Comanda order by comanda_id; 



-- inserare detalii comanda


INSERT INTO Detalii_comanda (cantitate, comanda_id, produs_id) VALUES (2, 1, 10); 
INSERT INTO Detalii_comanda (cantitate, comanda_id, produs_id) VALUES (1, 1, 12);
INSERT INTO Detalii_comanda (cantitate, comanda_id, produs_id) VALUES (3, 2, 13);
INSERT INTO Detalii_comanda (cantitate, comanda_id, produs_id) VALUES (1, 3, 11);
INSERT INTO Detalii_comanda (cantitate, comanda_id, produs_id) VALUES (5, 5, 14);

INSERT INTO Detalii_comanda (cantitate, comanda_id, produs_id) VALUES (2, 7, 1);
INSERT INTO Detalii_comanda (cantitate, comanda_id, produs_id) VALUES (1,8, 8);
INSERT INTO Detalii_comanda (cantitate, comanda_id, produs_id) VALUES (4, 9, 6);
select * from Detalii_comanda order by detalii_id;
--inserare feedback

INSERT INTO Feedback (stele, comentariu, data_feedback, client_id, produs_id) VALUES (5, 'Excelent!', DATE '2025-11-21', (SELECT client_id FROM Client WHERE email = 'costin.sandu@mail.com'), 11);
INSERT INTO Feedback (stele, comentariu, data_feedback, client_id, produs_id) VALUES (4, 'Bun, dar a ajuns cu intarziere.', DATE '2025-11-24',(SELECT client_id FROM Client WHERE email = 'ana.popescu@test.com'), 1);
INSERT INTO Feedback (stele, comentariu, data_feedback, client_id, produs_id) VALUES (5, 'Recomand cu incredere.', DATE '2025-11-16',(SELECT client_id FROM Client WHERE email = 'mihai.georgescu@fake.eu'), 7);
INSERT INTO Feedback (stele, comentariu, data_feedback, client_id, produs_id) VALUES (3, 'Pretul cam mare.', DATE '2025-11-20',(SELECT client_id FROM Client WHERE email = 'radu.ionescu@test.ro') , 8);
INSERT INTO Feedback (stele, comentariu, data_feedback, client_id, produs_id) VALUES (5, 'Calitate superioara.', SYSDATE,(SELECT client_id FROM Client WHERE email = 'elena.vasile@test.net'), 12);
select * from Feedback order by feedback_id;