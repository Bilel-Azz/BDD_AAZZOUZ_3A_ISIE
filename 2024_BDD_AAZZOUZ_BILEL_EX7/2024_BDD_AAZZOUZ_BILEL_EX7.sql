-- Ajout de lignes de données dans la table Reservation
INSERT INTO Reservation (DateReservation, DateDebutReservation, DateFinReservation, Utilisateur_ID, Materiel_ID, StatutReservation)
VALUES
    ('2024-04-01', '2024-04-01', '2024-04-03', 1, 1, 'confirmée'), -- Réservation 1
    ('2024-04-05', '2024-04-06', '2024-04-07', 2, 1, 'confirmée'), -- Réservation 2
    ('2024-04-10', '2024-04-11', '2024-04-12', 3, 1, 'confirmée'), -- Réservation 3
    ('2024-04-15', '2024-04-16', '2024-04-17', 4, 1, 'confirmée'); -- Réservation 4

-- Afficher tous les utilisateurs ayant emprunté au moins un équipement
SELECT DISTINCT Utilisateur.*
FROM Utilisateur
INNER JOIN Reservation ON Utilisateur.Id_user = Reservation.Utilisateur_ID;

-- Afficher les équipements n’ayant jamais été empruntés
SELECT *
FROM Materiel
WHERE ID_Materiel NOT IN (SELECT DISTINCT Materiel_ID FROM Reservation);

-- Afficher les équipements ayant été empruntés plus de 3 fois
SELECT Materiel.*, COUNT(Reservation.Materiel_ID) AS NbEmprunts
FROM Materiel
INNER JOIN Reservation ON Materiel.ID_Materiel = Reservation.Materiel_ID
GROUP BY Materiel.ID_Materiel
HAVING COUNT(Reservation.Materiel_ID) > 3;

-- Afficher le nombre d’emprunts pour chaque utilisateur
SELECT Utilisateur.Id_user, Utilisateur.Nom, Utilisateur.Prenom, COUNT(Reservation.Utilisateur_ID) AS NbEmprunts
FROM Utilisateur
LEFT JOIN Reservation ON Utilisateur.Id_user = Reservation.Utilisateur_ID
GROUP BY Utilisateur.Id_user, Utilisateur.Nom, Utilisateur.Prenom;

