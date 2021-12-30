drop schema if exists musique cascade;
create schema musique;
set search_path to musique;

---- TABLES ----
create table personne(
    idPersonne serial primary key,
    nom varchar,
    prenom varchar,
    naissance date
);

create table chanson(
    idChanson serial primary key,
    titre varchar,
    annee int,
    idAuteur int references personne(idPersonne)
);

create table chanter(
    idChanteur int references personne(idPersonne),
    idChanson int references chanson(idChanson),
    annee int,
    primary key(idChanteur,idChanson)
);

--- DONNEES ---
insert into personne (nom, prenom, naissance) values
('Dupond','Noel','2000-12-25'),
('Durand','Lise','2002-01-16'),
('Duval','Axel','2006-09-24'),
('Auteur1','prenom1','2006-09-24'),
('Auteur2','prenom2','2006-09-24');

insert into chanson (titre,annee,idAuteur) values
('titre1',2014,4),
('titre2',2015,4),
('titre3',2014,5);

insert into chanter values
(1,1,2016),
(1,2,2020),
(2,2,2020);


drop function est_pair();

create or replace function est_pair(nb int) returns boolean as $$
    BEGIN
        if nb%2=0 then
            return true;
        else
            return false;
        end if;
    end;
$$
language sql;

select est_pair(5);

create or replace function mois(nb int) returns char as $$
    BEGIN
        if nb=1 then
            return 'janvier';
        end if;
        if nb=2 then
            return 'février';
        end if;
        if nb=3 then
            return 'mars';
        end if;
        if nb=4 then
            return 'avril';
        end if;
        if nb=5 then
            return 'mai';
        end if;
        if nb=6 then
            return 'juin';
        end if;
        if nb=7 then
            return 'juillet';
        end if;
        if nb=8 then
            return 'aout';
        end if;
        if nb=9 then
            return 'septembre';
        end if;
        if nb=10 then
            return 'octobre';
        end if;
        if nb=11 then
            return 'novembre';
        end if;
        if nb=12 then
            return 'décembre';
        end if;
        if nb<1 then
            return null;
        end if;
        if nb>12 then
            return null;
        end if;
    end;
$$
language plpgsql;

select mois(1);

select personne.nom,date_part('month',naissance)
from personne;

create or replace function identite(id personne.idPersonne%type) returns personne.nom%type as
$$
DECLARE 
    n personne.nom%type;
begin 
    select nom into naissance
    from personne
    where idPersonne=id;
    if (found) then
        return n;
    end if;
    return 'inconnu';
end
$$
language plpgsql;


create or replace function nouveau(le_nom personne.nom%type,le_prenom personne.prenom%type,la_naissance personne.naissance%type) returns personne.idPersonne%type as 
$$
DECLARE
    n personne.idPersonne%type
begin
    PERFORM 1
    from personne
    where nom=le_nom and prenom=le_prenom and naissance=la_naissance;
    if(found) then   
        return null;
    end if;
    insert into personne values
    (default,le_nom,le_prenom,la_naissance)
    returning idPersonne into n;
    return n;
$$
language plpgsql;