-- Création du schéma de la BD SPORTS21_BDA_v2
-- Cette BD correspond à la BD SPORTS21_BDA_v1 sans aucune contrainte
-- Jean-François Condotta - 2021


DROP VIEW IF EXISTS V_CATEGORIE;
DROP TABLE IF EXISTS PRATIQUE;
DROP TABLE IF EXISTS PERSONNE;
DROP TABLE IF EXISTS SPORT;


CREATE TABLE PERSONNE (
	id_pers INT,
	nom VARCHAR(100),
	prenom VARCHAR(100),
	age INT
);

CREATE TABLE SPORT (
	id_sport INT,
	nom_sport VARCHAR(100),
	categorie VARCHAR(100)
);

CREATE TABLE PRATIQUE (
	id_pers INT,
	id_sport INT,
	nb_heures DECIMAL(5,2)
);

CREATE VIEW V_CATEGORIE AS
SELECT categorie,count(distinct id_sport) AS "nb_sports",count(id_pers) AS "nb_pers" 
FROM SPORT NATURAL JOIN PRATIQUE 
GROUP BY categorie
ORDER BY categorie ASC;
