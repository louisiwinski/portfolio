-- Fichier fonctions_examen_1_A
-- Jean-François Condotta - 2021

-- Votre nom : IWINSKI
-- Votre prénom : LOUIS
-- Votre groupe : 2b

-------------------------------------------------------------------------------------
-- Question 1 : la fonction SQL nb_produits_couteux

-- Mettre ici le code de la fonction SQL nb_produits_couteux


create or replace function nb_produits_couteux() 
returns int as
$$
DECLARE
    n INTEGER;
BEGIN
    select count(*) into n
    from produit 
    where produit.prix_prod>10;
    return n;
end;
$$
LANGUAGE plpgsql;






-- Test de la fonction nb_produits_couteux à décommenter pour l'utiliser.

SELECT * FROM nb_produits_couteux();
-------------------------------------------------------------------------------------
-- Question 2 : la fonction PL/SQL est_eleve

-- Mettre ici le code de la fonction PL/SQL est_eleve


create or replace function est_eleve(prix DECIMAL)
returns boolean as 
$$
BEGIN
    if prix>10.0 then
        return true;
    end if;
    return false;
end;
$$
LANGUAGE plpgsql;






-- Test de la fonction est_eleve à décommenter pour l'utiliser.

SELECT est_eleve(4),est_eleve(20);
-------------------------------------------------------------------------------------
-- Question 3 : la fonction PL/SQL nb_produits_couteux_bis 

-- Mettre ici le code de la fonction PL/SQL nb_produits_couteux_bis


create or replace function nb_produits_couteux_bis()
returns int as
$$
declare 
    n INTEGER;
BEGIN
    select count(*) into n
    from produit
    where produit.prix_prod>10;
    return n;
end;
$$
LANGUAGE plpgsql;








-- Test de la fonction nb_produits_couteux_bis à décommenter pour l'utiliser.

SELECT nb_produits_couteux_bis();
-------------------------------------------------------------------------------------
-- Question 4 : la fonction PL/SQL produit_couteux 

-- Mettre ici le code de la fonction PL/SQL produit_couteux 




create or replace function produit_couteux(id produit.id_prod%type)
returns VARCHAR as 
$$
begin
    perform *
    from produit
    where produit.id_prod=id;
    if not (found) then
        return 'inconnu';
    end if;
    if produit.prix_prod>10.0 then
        return 'couteux';
    end if;
    return 'pas couteux';
end;
$$
language plpgsql;




-- Test de la fonction produit_couteux à décommenter pour l'utiliser.

SELECT produit_couteux(0),produit_couteux(3),produit_couteux(20);
-------------------------------------------------------------------------------------
-- Question 5 : la fonction PL/SQL liste_produits_couteux 

-- Mettre ici le code de la fonction PL/SQL liste_produits_couteux 


create or replace function liste_produits_couteux()
returns varchar as
$$
begin 
    select produit.nom_prod
    from produit
    where produit.nom_prod>10;
end;
$$
language plpgsql;











-- Test de la fonction liste_produits_couteux à décommenter pour l'utiliser.

SELECT * FROM liste_produits_couteux();
-------------------------------------------------------------------------------------

