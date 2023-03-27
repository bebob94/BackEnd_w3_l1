/*DDL*/
CREATE TABLE IF NOT EXISTS utenti
(
    id serial NOT NULL PRIMARY KEY,
    nome character varying NOT NULL,
    cognome character varying NOT NULL,
    email character varying NOT NULL UNIQUE  
);

DROP TABLE utenti;
DROP TABLE provenienza;

CREATE TABLE IF NOT EXISTS utenti
(
    id serial NOT NULL PRIMARY KEY,
    nome VARCHAR NOT NULL,
    cognome VARCHAR NOT NULL,
    email VARCHAR NOT NULL UNIQUE,
    provenienza_id INT8 NOT NULL,
	constraint utenti_provenienza_fk FOREIGN KEY (provenienza_id)
		REFERENCES provenienza (id_provenienza)
		ON DELETE CASCADE 
		ON UPDATE CASCADE
);

TRUNCATE utenti;
TRUNCATE provenienza CASCADE;

ALTER TABLE utenti ADD cf VARCHAR NOT NULL UNIQUE;
ALTER TABLE utenti RENAME COLUMN cf TO codiceFiscale;
ALTER TABLE utenti DROP codiceFiscale;

CREATE TABLE IF NOT EXISTS provenienza
(
    id_provenienza serial NOT NULL PRIMARY KEY,
    citta VARCHAR NOT NULL,
	provincia VARCHAR NOT NULL,
    regione VARCHAR NOT NULL  
);

/*DML*/

INSERT INTO provenienza(citta, provincia, regione)
	VALUES ('Muravera', 'Cagliari', 'Sardegna');
INSERT INTO provenienza(citta, provincia, regione)
	VALUES ('Milano', 'Milano', 'Lombardia');
INSERT INTO provenienza(citta, provincia, regione)
	VALUES ('San vito', 'Cagliari', 'Sardegna');

INSERT INTO utenti(nome, cognome, email,provenienza_id)
	VALUES ('Bebo', 'Macis', 'bebo.macis@gmail.it',1);
INSERT INTO utenti(nome, cognome, email,provenienza_id)
	VALUES ('Daniele', 'Forma', 'kevin.Fuccio@gmail.com',2);



/*DQL*/

SELECT * FROM utenti;
SELECT * FROM provenienza;

SELECT * FROM provenienza WHERE regione ='Sardegna';
SELECT * FROM provenienza WHERE regione ='Sardegna' AND citta = 'Muravera';
SELECT citta FROM provenienza WHERE regione ='Sardegna';

SELECT  nome AS nome_utente, cognome AS cognome_utente,email, citta, provincia,regione FROM utenti
	INNER JOIN provenienza
	ON provenienza_id = id_provenienza;