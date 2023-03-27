CREATE TABLE IF NOT EXISTS clienti (
	numero_cliente SERIAL PRIMARY KEY,
	nome VARCHAR NOT NULL,
	cognome VARCHAR NOT NULL,
	dataDiNascita INT8 NOT NULL,
	regioneResidenza VARCHAR NOT NULL
)

CREATE TABLE IF NOT EXISTS fornitori(
	numeroFornitore SERIAL PRIMARY KEY,
	denominazione VARCHAR NOT NULL,
	regioneResidenza VARCHAR NOT NULL
)

CREATE TABLE IF NOT EXISTS fatture(
 	numeroFattura SERIAL PRIMARY KEY,
	tipologia VARCHAR NOT NULL,
	importo INT8 NOT NULL,
	iva INT8 NOT NULL,
	idCliente INT8 NOT NULL,
	CONSTRAINT invoices_client_FK FOREIGN KEY (idCliente)
		REFERENCES clienti(numero_cliente) 
		ON UPDATE CASCADE ON DELETE CASCADE,
	dataFattura DATE NOT NULL,
	numeroFornitore INT8 NOT NULL,
	CONSTRAINT fatture_fornitori_FK FOREIGN KEY (numeroFornitore) 
		REFERENCES fornitori (numeroFornitore)
		ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE prodotti(
	idProdotto SERIAL NOT NULL PRIMARY KEY,
	descrizione VARCHAR NOT NULL,
	marca VARCHAR NOT NULL,
	prezzo INT8 NOT NULL,
	in_produzione BOOLEAN NOT NULL DEFAULT 'false',
	in_commercio BOOLEAN NOT NULL DEFAULT 'false',
	data_attivazione DATE NOT NULL,
	data_disattivazione DATE
)

SELECT u.nome AS clients, u.cognome, c.idCliente AS invoices 
FROM clienti AS u INNER JOIN fatture AS c
ON c.idcliente = u.numero_cliente

INSERT INTO clienti (nome,cognome,dataDiNascita,regioneResidenza) 
	VALUES ('Bebo', 'Macis', 1994, 'SARDEGNA');
INSERT INTO clienti (nome,cognome,dataDiNascita,regioneResidenza) 
	VALUES ('Daniele', 'Testi', 2002, 'ROMA');
INSERT INTO clienti (nome,cognome,dataDiNascita,regioneResidenza) 
	VALUES ('Kevin', 'Fuccio', 2002, 'SICILIA');
INSERT INTO clienti (nome,cognome,dataDiNascita,regioneResidenza)
	VALUES ('Luca','Forma',1982,'LOMBARDIA' );

INSERT INTO fornitori (denominazione,regioneResidenza) 
	VALUES ('Fornitore 1', 'Emilia-Romagna');
INSERT INTO fornitori (denominazione,regioneResidenza) 
	VALUES ('Fornitore 2', 'Liguria');
INSERT INTO fornitori (denominazione,regioneResidenza) 
	VALUES ('Fornitore 3', 'Veneto');

INSERT INTO fatture (tipologia, importo ,iva, dataFattura,idCliente, numeroFornitore) 
	VALUES ('FATTURA', 20, 10,'2023-09-20',4,3);
INSERT INTO fatture (tipologia, importo ,iva, dataFattura,idCliente, numeroFornitore)
	VALUES ('NOTA DI ACCONTO', 25, 10,'2018-09-20',1,3);
INSERT INTO fatture (tipologia, importo ,iva, dataFattura,idCliente, numeroFornitore) 
	VALUES ('STORNO', 20, 20,'2012-09-20',2,2);
INSERT INTO fatture (tipologia, importo ,iva, dataFattura,idCliente, numeroFornitore) 
	VALUES ('FATTURA', 20, 20,'2020-09-20',1,1);

INSERT INTO prodotti (descrizione, marca, prezzo, in_produzione, in_commercio, data_attivazione,data_disattivazione)
	VALUES ('iPhone 13 Pro', 'Apple', 1199.00, true, true, '2022-09-20',null);
INSERT INTO prodotti (descrizione, marca, prezzo, in_produzione, in_commercio, data_attivazione,data_disattivazione)
	VALUES ('Galaxy S22', 'Samsung', 999.00, true, false, '2023-02-15',null);
INSERT INTO prodotti (descrizione, marca, prezzo, in_produzione, in_commercio, data_attivazione,data_disattivazione)
	VALUES ('Xperia 1 III', 'Sony', 1299.00, true, true, '2022-05-10',null);
INSERT INTO prodotti (descrizione, marca, prezzo, in_produzione, in_commercio, data_attivazione,data_disattivazione)
	VALUES ('iPhone 4', 'Apple', 109.00, false, false, '2005-09-10','2010-09-10');
INSERT INTO prodotti (descrizione, marca, prezzo, in_produzione, in_commercio, data_attivazione,data_disattivazione)
	VALUES ('one plus', 'Sony', 899.00, false, true, '2022-05-10',null);
INSERT INTO prodotti (descrizione, marca, prezzo, in_produzione, in_commercio, data_attivazione,data_disattivazione)
	VALUES ('iPhone 10', 'Apple', 1109.00, false, true, '2005-09-10','2010-09-10');

SELECT * from clienti;
SELECT * from fatture;
SELECT * from prodotti;
SELECT * from fornitori;

-- esercizio 1
SELECT nome, cognome from clienti where  datadinascita = 1982; 

-- esercizio2
SELECT numeroFattura from fatture where iva =20;

-- esercizio3
SELECT COUNT(*) AS numeroFattura, SUM(importo), EXTRACT(year from dataFattura) 
	FROM fatture
	GROUP BY dataFattura;
	
-- esercizio4
SELECT * FROM prodotti WHERE EXTRACT(YEAR FROM data_attivazione) = 2022 
	AND in_produzione = true
	AND in_commercio = true ;
	
-- esercizio5
SELECT COUNT(*),
	EXTRACT(year from dataFattura) AS data_fattura
	FROM fatture 
	WHERE iva = 20
	GROUP BY data_fattura;
	
-- esercizio6
SELECT EXTRACT(YEAR FROM dataFattura) 
	FROM fatture WHERE tipologia= 'FATTURA'
	GROUP BY dataFattura
	HAVING COUNT(fatture)>2;
	
-- esercizio7
SELECT fatture.tipologia, fatture.importo ,fatture.iva, fatture.dataFattura, fornitori.denominazione  
	FROM fatture 	
	INNER JOIN fornitori 
	ON fornitori.numeroFornitore = fatture.numerofornitore;
	
-- esercizio8


SELECT dataFattura FROM fatture GROUP BY dataFattura;