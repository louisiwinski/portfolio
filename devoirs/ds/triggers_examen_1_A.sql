-- Fichier triggers_examen_1_A
-- Jean-François Condotta - 2021

-- Votre nom :iwinski
-- Votre prénom : louis
-- Votre groupe :   2b

-------------------------------------------------------------------------------------
-- Question 1 : la fonction PL/SQL f_personne_br_i

-- Compléter ici le code de la fonction PL/SQL f_personne_br_i


CREATE OR REPLACE FUNCTION f_personne_br_i() 
RETURNS trigger AS
$$
BEGIN
    perform age
    from PERSONNE
    where personne.age=new.age;
    if new.age is null then
        insert into personne(age)
        values(30);
    end if;
    RETURN NEW;
END;
$$ 
LANGUAGE plpgsql;

-- Trigger associé à une insertion dans la table PERSONNE

CREATE TRIGGER trig_personne_br_i BEFORE INSERT ON PERSONNE
    FOR EACH ROW EXECUTE PROCEDURE f_personne_br_i();

-- Test du trigger trig_personne_br_i à décommenter pour l'utiliser.
INSERT INTO PERSONNE VALUES(20,'Martin','Paul',NULL);
SELECT * FROM PERSONNE WHERE id_pers=20;
-------------------------------------------------------------------------------------
-- Question 2 : la fonction PL/SQL f_produit_br_u

-- Compléter ici le code de la fonction PL/SQL f_produit_br_u


CREATE OR REPLACE FUNCTION f_produit_br_u() 
RETURNS trigger AS
$$
DECLARE
    n INTEGER;
BEGIN

    if produit.id_prod>4 then
        RAISE EXCEPTION 'Dépassement de quatre produits pour une catégorie !';
    end if;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger associé à une mise à jour dans la table PRODUIT

CREATE TRIGGER trig_produit_br_u BEFORE UPDATE ON PRODUIT
    FOR EACH ROW EXECUTE PROCEDURE f_produit_br_u();

-- Test du trigger trig_produit_br_u à décommenter pour l'utiliser.

SELECT * FROM PRODUIT;
UPDATE PRODUIT SET cat_prod='A' WHERE id_prod=4;
UPDATE PRODUIT SET cat_prod='E' WHERE id_prod=4;
SELECT * FROM PRODUIT;


-------------------------------------------------------------------------------------
-- Question 3 : la fonction PL/SQL f_achat_ar_d

-- Compléter ici le code de la fonction PL/SQL f_achat_ar_d


CREATE OR REPLACE FUNCTION f_achat_ar_d() 
RETURNS trigger AS
$$
BEGIN
    perform date_part('year',date_ach)
    from ACHAT
    where ACHAT.date_ach=new.date_ach;
    if 
    
  	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Trigger associé à une suppression dans la table ACHAT

CREATE TRIGGER trig_achat_ar_d AFTER DELETE ON ACHAT
    FOR EACH ROW EXECUTE PROCEDURE f_achat_ar_d();

-- Test du trigger trig_achat_ar_d à décommenter pour l'utiliser.

SELECT * FROM ACHAT;
DELETE FROM ACHAT WHERE id_pers=0 AND id_prod=0;
SELECT * FROM ACHAT;

-------------------------------------------------------------------------------------
