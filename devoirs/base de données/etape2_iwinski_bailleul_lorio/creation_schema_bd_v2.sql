-- Création du schéma de la BD achats -- 
-- Iwinski, Bailleul, Lorio - 2021


create schema achats;

DROP VIEW IF EXISTS view_1;
DROP TABLE IF EXISTS client;
DROP TABLE IF EXISTS produit;
DROP TABLE IF EXISTS achete;


CREATE TABLE client(
    id_client int,
    nom VARCHAR,
    prenom VARCHAR,
    age int
);

create table produit(
    id_produit int,
    nom_produit VARCHAR,
    prix_en_euros int
);

create table achete(
    id_client int,
    id_produit int,
    points_de_fidelite_gagnes int
);

CREATE VIEW view_1 AS
SELECT prix_en_euros,count(distinct id_produit) AS "nb_produit",count(id_client) AS "nb_client" 
FROM produit NATURAL JOIN achete 
GROUP BY prix_en_euros
ORDER BY prix_en_euros ASC;