-- Création du schéma de la BD SPORTS21_BDA_v3
-- Cette BD correspond à la BD SPORTS21_BDA_v2 avec des triggers
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

-- Fonction permettant de tester une insertion ou une mise à jour d'un tuple de la table SPORT
-- Voir les tests : Test SPORT 2 / Test SPORT 4 / Test SPORT 5 / Test SPORT 6 / Test SPORT 7 / Test SPORT 8  
CREATE OR REPLACE FUNCTION test_sport_br_iu() RETURNS trigger AS $$
    BEGIN
        IF NEW.id_sport IS NULL THEN
            RAISE EXCEPTION 'id_sport de SPORT ne peut pas être NULL !';
        END IF;
         IF NEW.nom_sport IS NULL THEN
            RAISE EXCEPTION 'nom_sport de SPORT ne peut pas être NULL !';
        END IF;
         IF NEW.categorie IS NULL THEN
            RAISE EXCEPTION 'categorie de SPORT ne peut pas être NULL !';
        END IF;
        IF NEW.id_sport<0 THEN
            RAISE EXCEPTION 'id_sport de SPORT doit être >=0 !';
        END IF;
         IF LENGTH(NEW.nom_sport)=0 THEN
            RAISE EXCEPTION 'Taille nom_sport de SPORT doit être différente de 0 !';
        END IF;
         IF LENGTH(NEW.categorie)=0 THEN
            RAISE EXCEPTION 'Taille de categorie de SPORT doit être différente de 0 !';
        END IF;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

-- Trigger permettant de tester une insertion ou une mise à jour d'un tuple de la table SPORT
-- Voir les tests : Test SPORT 2 / Test SPORT 4 / Test SPORT 5 / Test SPORT 6 / Test SPORT 7 / Test SPORT 8
CREATE TRIGGER trig_sport_br_iu BEFORE INSERT OR UPDATE ON SPORT
    FOR EACH ROW EXECUTE PROCEDURE test_sport_br_iu();

-- Fonction permettant de tester une insertion ou une mise à jour d'un tuple de la table SPORT
-- Voir les tests : Test SPORT 1 / Test SPORT 3 
CREATE OR REPLACE FUNCTION test_sport_ar_iu() RETURNS trigger AS $$
	DECLARE
	nb INTEGER;
    BEGIN
        SELECT COUNT(*) INTO nb
        FROM SPORT
        WHERE id_sport=NEW.id_sport;
        IF nb>1 THEN
        	RAISE EXCEPTION 'Deux tuples de SPORT ne peuvent pas avoir même valeur pour id_sport !';
        END IF; 
        SELECT COUNT(*) INTO nb
        FROM SPORT
        WHERE nom_sport=NEW.nom_sport;
        IF nb>1 THEN
        	RAISE EXCEPTION 'Deux tuples de SPORT ne peuvent pas avoir même valeur pour nom_sport !';
        END IF; 
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

-- Trigger permettant de tester une insertion ou une mise à jour d'un tuple de la table SPORT
-- Voir les tests : Test SPORT 1 / Test SPORT 3 
CREATE TRIGGER trig_sport_ar_iu AFTER INSERT OR UPDATE ON SPORT
    FOR EACH ROW EXECUTE PROCEDURE test_sport_ar_iu();

-- Fonction permettant de tester une insertion ou une mise à jour d'un tuple de la table PERSONNE
-- Voir les tests : Test PERSONNE 2 / Test PERSONNE 4 / Test PERSONNE 5 / Test PERSONNE 6 / Test PERSONNE 7
CREATE OR REPLACE FUNCTION test_personne_br_iu() RETURNS trigger AS $$
    BEGIN
        IF NEW.id_pers IS NULL THEN
            RAISE EXCEPTION 'id_pers de PERSONNE ne peut pas être NULL !';
        END IF;
         IF NEW.nom IS NULL THEN
            RAISE EXCEPTION 'nom de PERSONNE ne peut pas être NULL !';
        END IF;
         IF NEW.prenom IS NULL THEN
            RAISE EXCEPTION 'prenom de PERSONNE ne peut pas être NULL !';
        END IF;
        IF NEW.age<=0 THEN
            RAISE EXCEPTION 'age de PERSONNE doit être >0 !';
        END IF;
        IF NEW.id_pers<0 THEN
            RAISE EXCEPTION 'id_pers de PERSONNE doit être >=0 !';
        END IF;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

-- Trigger permettant de tester une insertion ou une mise à jour d'un tuple de la table PERSONNE
-- Voir les tests : Test PERSONNE 2 / Test PERSONNE 4 / Test PERSONNE 5 / Test PERSONNE 6 / Test PERSONNE 7
CREATE TRIGGER trig_personne_br_iu BEFORE INSERT OR UPDATE ON PERSONNE
    FOR EACH ROW EXECUTE PROCEDURE test_personne_br_iu();

-- Fonction permettant de tester une insertion ou une mise à jour d'un tuple de la table PERSONNE
-- Voir les tests : Test PERSONNE 1 / Test PERSONNE 3
CREATE OR REPLACE FUNCTION test_personne_ar_iu() RETURNS trigger AS $$
	DECLARE
	nb INTEGER;
    BEGIN
        SELECT COUNT(*) INTO nb
        FROM PERSONNE
        WHERE id_pers=NEW.id_pers;
        IF nb>1 THEN
        	RAISE EXCEPTION 'Deux tuples de PERSONNE ne peuvent pas avoir même valeur pour id_pers !';
        END IF; 
        SELECT COUNT(*) INTO nb
        FROM PERSONNE
        WHERE nom=NEW.nom AND prenom=NEW.prenom;
        IF nb>1 THEN
        	RAISE EXCEPTION 'Deux tuples de PERSONNE ne peuvent pas avoir mêmes valeurs pour nom et prénom !';
        END IF; 
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

-- Trigger permettant de tester une insertion ou une mise à jour d'un tuple de la table PERSONNE
-- Voir les tests : Test PERSONNE 1 / Test PERSONNE 3
CREATE TRIGGER trig_personne_ar_iu AFTER INSERT OR UPDATE ON PERSONNE
    FOR EACH ROW EXECUTE PROCEDURE test_personne_ar_iu();

-- Fonction permettant de tester une insertion ou une mise à jour d'un tuple de la table PRATIQUE
-- Voir les tests : Test PRATIQUE 2 / Test PRATIQUE 3 / Test PRATIQUE 4
CREATE OR REPLACE FUNCTION test_pratique_br_iu() RETURNS trigger AS $$
    BEGIN
        IF NEW.id_pers IS NULL THEN
            RAISE EXCEPTION 'id_pers de PRATIQUE ne peut pas être NULL !';
        END IF;
        IF NEW.id_sport IS NULL THEN
            RAISE EXCEPTION 'id_sport de PRATIQUE ne peut pas être NULL !';
        END IF;
         IF NEW.nb_heures<=0.0 THEN
            RAISE EXCEPTION 'nb_heures de PRATIQUE doit être >0.0 !';
        END IF;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;


-- Trigger permettant de tester une insertion ou une mise à jour d'un tuple de la table PRATIQUE
-- Voir les tests : Test PRATIQUE 2 / Test PRATIQUE 3 / Test PRATIQUE 4
CREATE TRIGGER trig_pratique_br_iu BEFORE INSERT OR UPDATE ON PRATIQUE
    FOR EACH ROW EXECUTE PROCEDURE test_pratique_br_iu();

-- Fonction permettant de tester une insertion ou une mise à jour d'un tuple de la table PRATIQUE
-- Voir les tests : Test PRATIQUE 1 / Test PRATIQUE 5 / Test PRATIQUE 6
CREATE OR REPLACE FUNCTION test_pratique_ar_iu() RETURNS trigger AS $$
	DECLARE
	nb INTEGER;
    BEGIN
        SELECT COUNT(*) INTO nb
        FROM PRATIQUE
        WHERE id_pers=NEW.id_pers AND id_sport=NEW.id_sport;
        IF nb>1 THEN
        	RAISE EXCEPTION 'Deux tuples de PRATIQUE ne peuvent pas avoir même valeur pour id_pers et id_sport !';
        END IF; 
        PERFORM COUNT(*)
        FROM PERSONNE
        WHERE id_pers=NEW.id_pers;
        IF NOT FOUND THEN
        	RAISE EXCEPTION 'id_pers de PRATIQUE référence id_pers de PERSONNE !';
        END IF; 
        PERFORM COUNT(*)
        FROM SPORT
        WHERE id_sport=NEW.id_sport;
        IF NOT FOUND THEN
        	RAISE EXCEPTION 'id_sport de SPORT référence id_sport de SPORT !';
        END IF; 
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

-- Trigger permettant de tester une insertion ou une mise à jour d'un tuple de la table PERSONNE
-- Voir les tests : Test PRATIQUE 1 / Test PRATIQUE 5 / Test PRATIQUE 6
CREATE TRIGGER trig_pratique_ar_iu AFTER INSERT OR UPDATE ON PRATIQUE
    FOR EACH ROW EXECUTE PROCEDURE test_pratique_ar_iu();
