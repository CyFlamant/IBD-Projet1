--Données de la table Serveur

INSERT INTO Serveur (NomServeur) VALUES
("Michel"), ("Nadia"), ("Béatrice")
;

--Données de la table TableResto

INSERT INTO TableResto (NumTable) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12);

--Données de la table Affectation (doivent normalement être entrées chaque jour)

INSERT INTO Affectation (NumServeur, NumTable, DateAffectation) VALUES
(1, 1, date()), (1, 2, date()), (1, 3, date()), (1, 4, date()), (2, 5, date()), (2,6, date()), (2,7, date()), (2,8, date()), (3,9, date()), (3, 10, date()), (3, 11, date()), (3, 12, date());


--Données de la table Article

INSERT INTO Article (Libelle, Prix, TypeArticle, TauxTVA) VALUES
("Salade mixte", 600, "Entrée", 10),
("Charcuterie", 800, "Entrée", 10),
("Potage", 700, "Entrée", 10),
("Entrecôte", 2000, "Plat principal", 10),
("Tartare de bœuf", 1500, "Plat principal", 10),
("Poulet rôti", 1800, "Plat principal", 10),
("Baba au rhum", 800, "Dessert", 10),
("Crêpe", 600, "Dessert", 10),
("Glace", 600, "Dessert", 10),
("Jus de fruit", 400, "Boisson sans alcool", 6),
("Eau minérale", 300, "Boisson sans alcool", 6),
("Bière pression", 400, "Boisson alcoolisée", 21),
("Vin rouge (verre)", 400, "Boisson alcoolisée", 21),
("Vin rouge (bouteille)", 2000, "Boisson alcoolisée", 21)
;

-- Commande n° 1 : commande et paiement
INSERT INTO Commande (NumAffectation, Heure)
VALUES (
    (SELECT NumAffectation FROM Affectation WHERE NumTable = 1 AND DateAffectation = date()),
    time('now')
);

INSERT INTO LigneCommande (NumArticle, NumCommande, Quantite) VALUES
(4,1, 2),
(8, 1, 2),
(12, 1, 2);

INSERT INTO Paiement (MontantPaye, ModePaiement, NumCommande)
VALUES (6000, 'Espèces', 1);


--Commande n° 2 : commande et paiement
INSERT INTO Commande (NumAffectation, Heure)
VALUES (
    (SELECT NumAffectation FROM Affectation 
     WHERE NumTable = 5 AND DateAffectation = date()),
    time('now')
);

INSERT INTO LigneCommande (NumArticle, NumCommande, Quantite) VALUES
(1, 2, 1),
(4, 2, 1),
(11, 2, 1),
(5, 2, 1),
(7, 2, 1),
(12, 2, 1);

INSERT INTO Paiement (MontantPaye, ModePaiement, NumCommande) VALUES
(3000, 'Espèces', 2),
(2600, 'Visa', 2);


--Commande n°3 : commande et paiement
INSERT INTO Commande (NumAffectation, Heure)
VALUES (
    (SELECT NumAffectation FROM Affectation 
     WHERE NumTable = 9 AND DateAffectation = date()),
    time('now')
);

INSERT INTO LigneCommande (NumArticle, NumCommande, Quantite) VALUES
(3, 3, 1),
(6, 3, 1),
(10, 3, 1),
(2, 3, 1),
(4, 3, 1),
(13, 3, 1);

INSERT INTO Paiement (MontantPaye, ModePaiement, NumCommande) VALUES
(3100, 'Espèces', 3),
(3000, 'Mastercard', 3);

--Commande n°4 : commande et paiement
INSERT INTO Commande (NumAffectation, Heure)
VALUES (
    (SELECT NumAffectation FROM Affectation 
     WHERE NumTable = 10 AND DateAffectation = date()),
    time('now')
);

INSERT INTO LigneCommande (NumArticle, NumCommande, Quantite) VALUES
(2, 4, 1),
(5, 4, 1),
(11, 4, 1),
(1, 4, 1),
(3,4, 1),
(12, 4, 1);

INSERT INTO Paiement (MontantPaye, ModePaiement, NumCommande) VALUES
(4300, 'Espèces', 4);
