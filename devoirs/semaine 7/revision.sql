create or replace function est_pair(n int)
returns boolean as
$$
begin 
    if n%2=0 then
        return true;
    end if;
    return false;
end;
$$
language plpgsql;

select est_pair(8);

select chanson.titre 
from chanson
where not est_pair(annee);


create or replace function mois(n int)
returns varchar as
$$
BEGIN
    return case n
        when 1 return 'janvier'
        when 2 return 'fevrier'
        when 3 return 'mars'
        when 4 return 'avril'
        when 5 return 'mai'
        when 6 return 'juin'
        when 7 return 'juillet'
        when 8 return 'aout'
        when 9 return 'septembre'
        when 10 return 'octobre'
        when 11 return 'novembre'
        when 12 return 'decembre'
    end;
end;
$$
language plpgsql;


select mois(9);

select personne.nom,mois(date_part('month',naissance)::int)
from personne;


create or replace function identite(id personne.idPersonne%type)
returns personne.nom%type as 
$$
declare
    n personne.nom%type;
begin
    select nom into n
    from personne
    where idPersonne=id;
    if (found) then
        return n;
    end if;
    return 'inconnu';
end;
$$
language plpgsql;


create or replace function nouveau(le_nom personne.nom%type,le_prenom personne.prenom%type,la_naissance personne.naissance%type) 
returns personne.idPersonne%type as
$$
declare 
    n personne.idPersonne%type;
begin
    perform 1
    from personne
    where nom=le_nom and prenom=le_prenom and la_naissance=naissance;
    if (found) then
        return null;
    end if;
    insert into personne 
    values(default,'toto','toto','2020-52-55');
    returning idPersonne into n;
    return n;
end;
$$
language plpgsql;



create or replace function les_mois(n1 int,n2 int)
returns setof as 
$$
begin 
    for i in n1..n2 loop
        return next mois(i);
    end loop;
    return;
end;
language plpgsql;