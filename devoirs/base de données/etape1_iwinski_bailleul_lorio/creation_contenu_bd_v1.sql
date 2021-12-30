-- Création du contenu initial de la BD achats de Iwinski,Bailleul et Lorio
-- 2021

DELETE FROM client;
DELETE FROM produit;
DELETE FROM achete;


INSERT INTO client(id_client,nom,prenom,age) VALUES
(1,'Lorio','Theo',21),
(2,'Iwinski','Louis',19),
(3,'Bailleul','Gabriel',19),
(4,'Cafee','Milla',54),
(5,'Henry','Thierry',41),
(6,'James','LeBron',36),
(7,'Reece','Frederica',22),
(8,'Baudelaire','Antoine',62),
(9,'Saint Exupery','Charles',78),
(10,'Dani','Carles',36),
(11,'Lemsi','Hayce',45),
(12,'Mickal','Jonas',18),
(13,'Ghezzal','Rachid',29),
(14,'Le Sommer','Eugénie',27),
(15,'Jolie','Angelina',37);

INSERT INTO produit(id_produit,nom_produit,prix_en_euros) VALUES
(1,'Ballon de basket',15),
(2,'T-shirt RC Lens',60),
(3,'Sac',20),
(4,'Kayak',150),
(5,'Chaussettes',8),
(6,'Protéines',4),
(7,'Sacoche',7),
(8,'Bermudas',15),
(9,'Eau',3),
(10,'Chasuble',10),
(11,'Chaussures',50),
(12,'Drapeau',14),
(13,'Protege genou',40),
(14,'Panier basket',80),
(15,'Velo',160);

INSERT INTO achete(id_client,id_produit,points_de_fidelite_gagnes) VALUES
(1,6,5),
(1,10,5),
(3,13,20),
(4,8,10),
(5,1,10),
(6,15,80),
(7,3,10),
(8,6,5),
(9,4,70),
(10,5,5),
(11,14,40),
(12,2,30),
(13,6,5),
(14,3,10),
(15,11,20);