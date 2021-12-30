set search_path to musique;
--- fonctions PL/SQL basiques ---

-- 1 : n est-il pair? --
create or replace function est_pair(n int)
returns boolean as
$$
begin
    if n%2 = 0 then 
        return true;  
    end if;
    return false;
end
$$ language plpgsql;
-- 2
select est_pair(5);
select est_pair(8);
-- 3
select *
from chanson
where not est_pair(annee);

-- 4 : les noms des mois --
create or replace function mois(n int)
returns varchar as
$$
begin
    if n=1 then  return 'janvier';
    elsif n=2 then return 'fevrier';
    elsif n>2 and n<=12 then return 'autre';
    else return null;
    end if;
end
$$ language plpgsql;

-- test 1 : array
drop function ff(int);
create or replace function ff(x int) returns varchar as
$$
declare
    mois varchar[5];
begin
    mois = ARRAY['Janvier','Fevrier'];
    return coalesce(mois[x],'autre');
end
$$ language plpgsql;

-- test 2 : case .. when
drop function ff2(int);
create or replace function ff2(x int) returns varchar as
$$
begin
    return case x
        when 1 then 'Janvier'
        when 2 then 'Fevrier'
    end ;
end
$$ language plpgsql; 

-- 5
select mois(1);
select mois(2);
select mois(4);
select mois(0);

-- 6
select nom, mois(date_part('month',naissance)::int)
from personne;


-- 7 : les personnes inconnues --
create or replace function identite(id personne.idPersonne%type)
returns personne.nom%type as
$$
declare
    n personne.nom%type;
begin
    select nom into n
    from personne
    where idPersonne = id;
    if (found) then
      return n;
    end if;
    return 'inconnu';
end
$$ language plpgsql;

-- 8
select identite(1);
select identite(10);

-- 9 : nouvelle personne --
create or replace function nouveau(le_nom personne.nom%type,le_prenom personne.prenom%type,la_naissance personne.naissance%type)
returns personne.idPersonne%type as
$$
declare
    n personne.idPersonne%type;
begin
    perform 1
    from personne
    where nom=le_nom and prenom=le_prenom and naissance=la_naissance;
    if(found) then
      return null;
    end if;
    insert into personne
    values(default,le_nom,le_prenom,la_naissance)
    returning idPersonne into n;

    return n;

end
$$ language plpgsql;

-- 10
select nouveau('titi','toto','2000-01-02');

-- 11 : les noms des mois
create or replace function les_mois(n1 int, n2 int)
returns setof varchar as
$$
begin
    for i in n1..n2 loop
      return next mois(i);
    end loop;
    return;
end
$$ language plpgsql;

-- 12
select * from les_mois(0,5);

-- 13 : les noms des mois
create or replace function les_personnes(d1 date, d2 date)
returns table(
  n personne.nom%type,
  p personne.prenom%type
) as
$$
begin
    for n,p in select nom,prenom from personne
               where naissance between d1 and d2 loop
    return next;
    end loop;
    return;
end
$$ language plpgsql;

-- 14
select * from les_personnes('2000-01-01','2005-01-01');

-- 15 : insertion de données aléatoire
drop table test;
create table test(
  id serial primary key,
  data varchar
);

create or replace function mot(n int)
returns varchar as
$$
declare
  m varchar='';
begin
  for i in 1..n loop
    m = m || chr(65 + floor(random()*26)::int);
  end loop;
  return m;
end
$$ language plpgsql;

select mot(5);

create or replace function aleatoire(n int, x int)
returns void as
$$
begin
    for i in 1..n loop
      insert into test(data)
      values (mot(x))  ;
    end loop;
end
$$ language plpgsql;

select aleatoire(10,6);
select * from test;



