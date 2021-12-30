-- Création du schéma de la BD achats -- 
-- Iwinski, Bailleul, Lorio - 2021


create schema achats;

DROP VIEW IF EXISTS view_1;
DROP TABLE IF EXISTS client;
DROP TABLE IF EXISTS produit;
DROP TABLE IF EXISTS achete;


CREATE TABLE client(
    id_client int PRIMARY KEY,
    nom VARCHAR(20) NOT NULL,
    prenom VARCHAR(20) NOT NULL,
    age int,
    CHECK(id_client>0),
    CHECK(age>0),
    UNIQUE(nom),
    UNIQUE(id_client)
);

create table produit(
    id_produit int PRIMARY KEY,
    nom_produit VARCHAR(50) NOT null,
    prix_en_euros int NOT NULL,
    CHECK(prix_en_euros>=0),
    CHECK(id_produit>0),
    UNIQUE(nom_produit)
);

create table achete(
    id_client int,
    id_produit int,
    points_de_fidelite_gagnes int,
    PRIMARY KEY(id_produit,id_client),
    FOREIGN KEY(id_client) REFERENCES client(id_client) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(id_produit) REFERENCES produit(id_produit) ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK(points_de_fidelite_gagnes>=0)
);

CREATE VIEW view_1 AS
SELECT prix_en_euros,count(distinct id_produit) AS "nb_produit",count(id_client) AS "nb_client" 
FROM produit NATURAL JOIN achete 
GROUP BY prix_en_euros
ORDER BY prix_en_euros ASC;


