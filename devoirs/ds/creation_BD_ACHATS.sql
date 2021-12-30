-- Création du schéma et initialisation du contenu de la base de données BD_ACHATS
-- Jean-François Condotta - 2021

DROP SCHEMA IF EXISTS BD_ACHATS CASCADE;
CREATE SCHEMA BD_ACHATS;
SET search_path TO BD_ACHATS;

CREATE TABLE PERSONNE (
	id_pers INT PRIMARY KEY,
	nom VARCHAR(100) NOT NULL,
	prenom VARCHAR(100) NOT NULL,
	age INT,
	CHECK(id_pers>=0),
	CHECK(age>0),
	UNIQUE(nom,prenom)
);

CREATE TABLE PRODUIT (
	id_prod INT PRIMARY KEY,
	nom_prod VARCHAR(100) NOT NULL,
	cat_prod CHAR(1) NOT NULL,
	prix_prod DECIMAL NOT NULL,
	CHECK(LENGTH(nom_prod)>0),
	UNIQUE(nom_prod),
	CHECK(id_prod>=0),
	CHECK(prix_prod>=0.0)
);

CREATE TABLE ACHAT (
	id_pers INT,
	id_prod INT,
	qte_ach INT NOT NULL,
	date_ach DATE,
	CHECK(qte_ach>0.0),
	PRIMARY KEY (id_pers,id_prod,date_ach),
	FOREIGN KEY (id_pers) REFERENCES PERSONNE(id_pers) 
	ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_prod) REFERENCES PRODUIT(id_prod)
	ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO PERSONNE VALUES
(0,'Dujardin','Marc',20),
(1,'Devos','Evelyne',43),
(2,'Panahi','Mahmoud',38),
(3,'Buzek','Elsa',50),
(4,'Amalric','Jeanne',20),
(5,'Pheonix','Arthur',32),
(6,'Panahi','Michel',18),
(7,'Buzek','Alexis',52),
(8,'Amalric','Bilal',22),
(9,'Pheonix','Sonia',42)
;

INSERT INTO PRODUIT VALUES
(0,'Produit 1','A',10.0),
(1,'Produit 2','A',10.0),
(2,'Produit 3','A',20.0),
(3,'Produit 4','A',22.0),
(4,'Produit 5','B',21.0),
(5,'Produit 6','B',12.0),
(6,'Produit 7','B',8.0),
(7,'Produit 8','C',9.0),
(8,'Produit 9','C',14.0),
(9,'Produit 10','C',15.0)
;

INSERT INTO ACHAT VALUES
(0,0,10,'2021-11-18'),
(0,0,5,'2021-05-04'),
(0,5,22,'2021-11-08'),
(0,7,8,'2020-11-23'),
(1,0,10,'2021-01-08'),
(1,2,15,'2019-04-08'),
(2,9,20,'2021-06-08'),
(4,0,34,'2020-11-08'),
(4,1,12,'2020-06-08'),
(4,4,1,'2021-07-08'),
(4,8,7,'2021-05-08'),
(5,3,15,'2019-05-08'),
(5,4,12,'2021-10-08'),
(5,1,14,'2020-10-08'),
(5,2,17,'2021-10-08')
;

SELECT * FROM PERSONNE;
SELECT * FROM PRODUIT;
SELECT * FROM ACHAT;



