import sqlite3

# Connexion à la base de données
conn = sqlite3.connect("resto.db")
cursor = conn.cursor()

#Saisie du numéro de commande
num_commande = input("Numéro de la commande : ")

#Interrogation de la base de données pour les données élémentaires
cursor.execute("""
    SELECT c.Heure, a.DateAffectation, s.NomServeur, t.NumTable
    FROM Commande c
    JOIN Affectation a ON c.NumAffectation = a.NumAffectation
    JOIN Serveur s ON a.NumServeur = s.NumServeur
    JOIN TableResto t ON a.NumTable = t.NumTable
    WHERE c.NumCommande = ?
""", (num_commande,))
info = cursor.fetchone()

# N° de commande introuvable
if not info:
    print("Commande introuvable.")
    exit()

#Affichage des données récupérées
heure, date, serveur, table = info

print("=== TICKET DE CAISSE ===")
print("Date :", date)
print("Heure :", heure)
print("Table :", table)
print("Serveur :", serveur)
print()
print("Articles :")

#Interrogation de la db pour les données calculées
cursor.execute("""
    SELECT ar.Libelle, lc.Quantite, ar.Prix, ar.TauxTVA
    FROM LigneCommande lc
    JOIN Article ar ON lc.NumArticle = ar.NumArticle
    WHERE lc.NumCommande = ?
""", (num_commande,))
lignes = cursor.fetchall()

#initialisation des totaux
ttc_total = 0
ht_total = 0
total_articles = 0
tva = {}

#calcul des montants et de la tva pour chaque ligne
for libelle, qte, prix_ttc, taux in lignes:
    total_ligne = qte * prix_ttc
    ht_ligne = total_ligne / (1 + taux / 100)
    montant_tva = total_ligne - ht_ligne
    ttc_total += total_ligne
    ht_total += ht_ligne
    total_articles += qte
    tva[taux] = tva.get(taux, 0) + montant_tva
    print(f"{libelle} x{qte} : {total_ligne / 100:.2f} €")

#Affichage des totaux
print()
print("Total articles :", total_articles)
print("Total TTC :", f"{ttc_total / 100:.2f} €")
print("Total HT :", f"{ht_total / 100:.2f} €")
print("TVA :")
for taux in sorted(tva):
    print(f"  {taux}% : {tva[taux] / 100:.2f} €")

#Interrogation de la db pour les paiements
cursor.execute("""
    SELECT ModePaiement, MontantPaye
    FROM Paiement
    WHERE NumCommande = ?
""", (num_commande,))
paiements = cursor.fetchall()

#Affichage des paiements
print("Paiement :")
for mode, montant in paiements:
    print(f"  {mode} : {montant / 100:.2f} €")

#Fermeture de la connexion
conn.close()
