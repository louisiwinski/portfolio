-- Création du schéma de la BD SPORTS21_BDA_v1
-- Jean-François Condotta - 2021


DROP VIEW IF EXISTS V_CATEGORIE;
DROP TABLE IF EXISTS PRATIQUE;
DROP TABLE IF EXISTS PERSONNE;
DROP TABLE IF EXISTS SPORT;


CREATE TABLE PERSONNE (
	id_pers INT PRIMARY KEY,
	nom VARCHAR(100) NOT NULL,
	prenom VARCHAR(100) NOT NULL,
	age INT,
	CHECK(id_pers>=0),
	CHECK(age>0),
	UNIQUE(nom,prenom)
);

CREATE TABLE SPORT (
	id_sport INT PRIMARY KEY,
	nom_sport VARCHAR(100) NOT NULL,
	categorie VARCHAR(100) NOT NULL,
	CHECK(LENGTH(nom_sport)>0),
	CHECK(LENGTH(categorie)>0),
	UNIQUE(nom_sport),
	CHECK(id_sport>=0)
);

CREATE TABLE PRATIQUE (
	id_pers INT,
	id_sport INT,
	nb_heures DECIMAL(5,2),
	CHECK (nb_heures>0.0),
	PRIMARY KEY (id_pers,id_sport),
	FOREIGN KEY (id_pers) REFERENCES PERSONNE(id_pers) 
	ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_sport) REFERENCES SPORT(id_sport)
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE VIEW V_CATEGORIE AS
SELECT categorie,count(distinct id_sport) AS "nb_sports",count(id_pers) AS "nb_pers" 
FROM SPORT NATURAL JOIN PRATIQUE 
GROUP BY categorie
ORDER BY categorie ASC;
