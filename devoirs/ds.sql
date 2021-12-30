create or REPLACE function nb_produits_couteux() returns int as
$$
select count(*)::int
from produit
where prix_prod>10;
$$
LANGUAGE SQL;


create or replace function est_eleve(prix int) returns boolean as 
$$
begin 
    return prix>10;
end;
$$
LANGUAGE plpgsql;


create or replace function nb_produits_couteux_bis()
returns int AS
$$
DECLARE
    nb int;
begin 
    select count(*) into nb
    from produit
    where prix_prod>10;
    return nb;
end
$$
LANGUAGE plpgsql;


create or replace function produit_couteux(id int)
returns varchar as 
$$
begin 
    perform prix_prod from produit where id_prod=id;
    if not found then
        return 'inconnu';
    end if;
    if((select prix_prod from produit where id_prod =id)>10) then
        return 'couteux';
    end if;
    return 'pas couteux';
end;
$$
LANGUAGE plpgsql;



create or replace function liste_produit_couteux() returns produit as
$$
declare 
    prod produit;
begin
    for prod in select * from produit where prix_prod >10.0 loop
        return next prod;
    end loop;
end 
$$
LANGUAGE plpgsql;

create or replace function f_produit_br_u() returns trigger as 
$$
declare 
    n integer;
begin 
    select count(*) into n from produit where cat_prod =NEW.cat_prod;
    if(n>4) then 
        RAISE EXCEPTION 'la categorie % contient plus de 4 produits',new.cat_prod;
    end if;
    return new;
end;
$$
LANGUAGE plpgsql;


create or replace function f_achat_ar_d() returns trigger as 
$$
begin 
    delete from achat where date_part('year',date_ach)=date_part('year',old.date_ach);
return null;
end;
$$
LANGUAGE plpgsql;