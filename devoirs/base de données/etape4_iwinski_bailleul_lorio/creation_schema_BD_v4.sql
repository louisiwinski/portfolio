-- Création du schéma de la BD_v4
-- Iwinski,Lorio,Bailleul - 2021

DROP SCHEMA IF EXISTS achats CASCADE;
CREATE SCHEMA achats;

create table client(
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


-- Vue comptabilisant le nombre de produit par leur prix
CREATE VIEW view_count_produit AS
SELECT prix_en_euros,count(*) as "nb_sports"
FROM produit
GROUP BY prix_en_euros
ORDER BY prix_en_euros;


-- Table comptabilisant le nombre de produit par prix_en_euros
create table table_nb_produit_prix (
	prix_en_euros INT PRIMARY KEY,
	nb_produit int,
	CHECK (nb_produit>0)
);


--fonction permettant de mettre à jour la table table_nb_produit_prix après une insertion d'un tuple dans la table produit.
CREATE OR REPLACE FUNCTION maj_table_nb_produit_prix_after_insert() RETURNS trigger AS 
$$
	DECLARE
	nb_p INTEGER;
    BEGIN
		select count(*) into nb_p
		from table_nb_produit_prix
		where prix_en_euros=NEW.prix_en_euros;
		if nb_p<0 then
            RAISE EXCEPTION 'deux tuples de produit ne peuvent pas avoir la même valeur'
        end if;

    END;
$$ 
LANGUAGE plpgsql;

-- Fonction permettant de mettre à jour la table table_nb_produit_prix après une insertion d'un tuple dans la table produit.
CREATE TRIGGER trigger_produit_after_insert AFTER INSERT ON produit
    FOR EACH ROW EXECUTE PROCEDURE maj_table_nb_produit_prix_after_insert();




-- Fonction permettant de mettre à jour la table T_NB_SPORT_PAR_CATEGORIE après une suppression d'un tuple dans la table SPORT.
CREATE OR REPLACE FUNCTION maj_t_nb_sports_par_categorie_ar_d() RETURNS trigger AS $$
	DECLARE
	nb INT;
    BEGIN

	-- A REMPLIR
	
    RETURN NULL;
    END;
$$ LANGUAGE plpgsql;

-- Fonction permettant de mettre à jour la table T_NB_SPORT_PAR_CATEGORIE après une insertion d'un tuple dans la table SPORT.
CREATE TRIGGER trig_sport_ar_d AFTER DELETE ON SPORT
    FOR EACH ROW EXECUTE PROCEDURE maj_t_nb_sports_par_categorie_ar_d();

-- Fonction permettant de mettre à jour la table T_NB_SPORT_PAR_CATEGORIE après une maj d'un tuple dans la table SPORT.
CREATE OR REPLACE FUNCTION maj_t_nb_sports_par_categorie_ar_u() RETURNS trigger AS $$
	DECLARE
	nb INT;
    BEGIN

    -- A REMPLIR
    
    RETURN NULL;
    END;
$$ LANGUAGE plpgsql;

-- Fonction permettant de mettre à jour la table T_NB_SPORT_PAR_CATEGORIE après une insertion d'un tuple dans la table SPORT.
CREATE TRIGGER trig_sport_ar_u AFTER UPDATE ON SPORT
    FOR EACH ROW EXECUTE PROCEDURE maj_t_nb_sports_par_categorie_ar_u();
