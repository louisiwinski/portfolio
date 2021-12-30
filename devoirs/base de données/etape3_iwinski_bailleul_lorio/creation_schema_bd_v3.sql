-- Création du schéma de la BD achats -- 
-- Cette bd correspond à la BD achats avec des triggers --
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

-- Produit --
--fonction test_produit_before_iu() qui teste l'insertion ou la mise à jour d'un tuple de la table produit--
CREATE OR REPLACE FUNCTION test_produit_before_iu() RETURNS trigger AS 
$$
    BEGIN
        IF NEW.id_produit IS NULL THEN
            RAISE EXCEPTION 'id_produit de Produit ne peut pas être NULL';
        END IF;
        IF NEW.nom_produit IS NULL THEN
            RAISE EXCEPTION 'nom_produit de Produit ne peut pas être NULL';
        END IF;
        IF NEW.prix_en_euros IS NULL THEN
            RAISE EXCEPTION 'prix_en_euros de Produit ne peut pas être NULL';
        END IF;
        IF NEW.id_produit<=0 THEN
            RAISE EXCEPTION 'id_produit de Produit doit être >0 ';
        END IF;
        IF LENGTH(NEW.nom_produit)=0 THEN
            RAISE EXCEPTION 'la taille des nom_produit de Produit doit être differente de 0';
        END IF;
        IF NEW.prix_en_euros<0 THEN
            RAISE EXCEPTION 'prix_en_euros de Produit doit être >=0';
        END IF;
        RETURN NEW;
    END;
$$
LANGUAGE plpgsql;

--ce trigger permet d'executer la procédure test_produit_before_iu() avant l'insertion ou une mise à jour d'un tuple de la table produit--
CREATE TRIGGER trigger_produit__before_iu BEFORE INSERT OR UPDATE ON produit 
    FOR EACH ROW EXECUTE PROCEDURE test_produit_before_iu();


--fonction test_produit_after_iu() qui teste l'insertion ou la mise à jour d'un tuple de la table produit--
CREATE OR REPLACE FUNCTION test_produit_after_iu() RETURNS trigger AS
$$
    DECLARE
    nb INTEGER;
    BEGIN
        select count(*) into nb
        from produit
        where id_produit=NEW.id_produit;
        if nb>1 then 
            RAISE EXCEPTION 'Deux tuples (pour id_produit) de Produit ne peuvent pas avoir la même valeur';
        end if;
        select count(*) into nb
        from produit
        where nom_produit=NEW.nom_produit;
        if nb>1 then
            RAISE EXCEPTION 'Deux tuple (pour nom_produit) ne peuvent pas avoir la même valeur';
        END IF;
        RETURN NEW;
    END;
$$
LANGUAGE plpgsql;

--ce trigger permet d'executer la procédure test_produit_after_iu() après l'insertion ou une mise à jour d'un tuple de la table produit--
CREATE TRIGGER trigger_produit_after_iu AFTER INSERT OR UPDATE ON PRODUIT 
    FOR EACH ROW EXECUTE PROCEDURE test_produit_after_iu();



--Client--
--fonction test_client_before_iu() qui teste l'insertion ou la mise à jour d'un tuple de la table client--
CREATE OR REPLACE FUNCTION test_client_before_iu() RETURNS trigger AS 
$$
    BEGIN
        IF NEW.id_client IS NULL THEN 
            RAISE EXCEPTION 'id_client de client ne peut pas être NULL';
        END IF;
        IF NEW.nom IS NULL THEN
            RAISE EXCEPTION 'nom de client ne peut pas être NULL';
        END IF;
        IF NEW.prenom IS NULL THEN
            RAISE EXCEPTION 'prenom de client ne peut pas être NULL';
        END IF;
        IF NEW.age<=0 THEN
            RAISE EXCEPTION 'age de client doit être >0';
        END IF;
        IF NEW.id_client<=0 THEN
            RAISE EXCEPTION 'id_client de client doit être >0';
        END IF;
        IF LENGTH(NEW.nom)=0 THEN
            RAISE EXCEPTION 'taille de nom de client doit être différente de 0';
        END IF;
        IF LENGTH(NEW.prenom)=0 THEN
            RAISE EXCEPTION 'taille de prenom de client doit être différente de 0';
        END IF;
        RETURN NEW;
    END;
$$
LANGUAGE plpgsql;

--ce trigger permet d'executer la procédure test_client_before_iu() après l'insertion ou une mise à jour d'un tuple de la table client--
CREATE TRIGGER trigger_client_before_iu BEFORE INSERT OR UPDATE ON CLIENT 
    FOR EACH ROW EXECUTE PROCEDURE test_client_before_iu();


--fonction test_client_after_iu() qui teste l'insertion ou la mise à jour d'un tuple de la table client--
CREATE OR REPLACE FUNCTION test_client_after_iu() RETURNS trigger AS 
$$
    DECLARE
    nb INTEGER;
    BEGIN 
        select count(*) into nb
        from client
        where id_client=NEW.id_client;
        if nb>1 then
            RAISE EXCEPTION 'deux tuples de client(id_client) ne peuvent pas avoir la même valeur';
        end if;
        select count(*) into nb
        from client
        where nom=NEW.nom;
        if nb>1 then
            RAISE EXCEPTION 'deux tuples de client(nom) ne peuvent pas avoir la même valeur';
        end if;
        select count(*) into nb
        from client
        where prenom=NEW.prenom;
        if nb>1 then
            RAISE EXCEPTION 'deux tuples de client(prenom) ne peuvent pas avoir la même valeur';
        end if;
        RETURN NEW;
    END;
$$
LANGUAGE plpgsql;

--ce trigger permet d'executer la procédure test_client_after_iu() après l'insertion ou une mise à jour d'un tuple de la table client--
CREATE TRIGGER trigger_client_after_iu AFTER INSERT OR UPDATE ON CLIENT
    FOR EACH ROW EXECUTE PROCEDURE test_client_after_iu();





--Achete--
--fonction test_achete_before_iu() qui teste l'insertion ou la mise à jour d'un tuple de la table ACHETE--
CREATE OR REPLACE FUNCTION test_achete_before_iu() RETURNS trigger AS 
$$
    BEGIN 
        IF NEW.id_client IS NULL THEN   
            RAISE EXCEPTION 'id_client de achete ne peut pas être NULL';
        END IF;
        IF NEW.id_produit IS NULL THEN
            RAISE EXCEPTION 'id_produit de achete ne peut pas être NULL';
        END IF;
        IF NEW.points_de_fidelite_gagnes<=0 THEN
            RAISE EXCEPTION 'points_de_fidelite_gagnes de achete ne peut pas être NULL';
        END IF;
        RETURN NEW;
    END
$$
LANGUAGE plpgsql;


--ce trigger permet d'executer la procédure test_achete_before_iut() avant l'insertion ou une mise à jour d'un tuple de la table achete--
CREATE TRIGGER trigger_pratique_after_iu BEFORE INSERT OR UPDATE ON ACHETE 
    FOR EACH ROW EXECUTE PROCEDURE test_achete_before_iu();


--fonction test_achete_after_iut() qui teste l'insertion ou la mise à jour d'un tuple de la table ACHETE--
CREATE OR REPLACE FUNCTION test_achete_after_iut() RETURNS trigger AS 
$$
    DECLARE
    nb INTEGER;
    BEGIN
        select count(*) into nb
        from achete 
        where id_client=NEW.id_client;
        if nb>1 then
            RAISE EXCEPTION 'deux tuples de achete(id_client) ne peuvent pas avoir la même valeur';
        end if;
        select count(*) into nb
        from achete 
        where id_produit=NEW.id_produit;
        if nb>1 then
            RAISE EXCEPTION 'deux tuples de achete(id_produit) ne peuvent pas avoir la même valeur';
        end if;
        PERFORM count(*)
        from achete
        where id_client=NEW.id_client;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'id_client de achete référence id_client de la table client';
        end if;
        PERFORM COUNT(*)
        from achete 
        where id_produit=NEW.id_produit;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'id_produit de achete référence id_produi de la table produit';
        end if;
        RETURN NEW;
    END;
$$
LANGUAGE plpgsql;


--ce trigger permet d'executer la procédure test_achete_after_iut() après l'insertion ou une mise à jour d'un tuple de la table achete--
CREATE TRIGGER trigger_achete_after_iu AFTER INSERT OR UPDATE ON ACHETE
    FOR EACH ROW EXECUTE PROCEDURE test_achete_after_iut();