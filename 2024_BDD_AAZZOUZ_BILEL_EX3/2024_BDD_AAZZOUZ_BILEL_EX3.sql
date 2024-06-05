-- Cette requête récupère les noms et prénoms des utilisateurs qui ont effectué une réservation,
-- ainsi que les dates de début et de fin de leurs réservations.
SELECT Utilisateur.Nom, Utilisateur.Prenom, Reservation.DateDebutReservation, Reservation.DateFinReservation
FROM Utilisateur
INNER JOIN Reservation ON Utilisateur.Id_user = Reservation.Utilisateur_ID;

-- Cette requête récupère le nom, la description du matériel réservé,
-- ainsi que les dates de début et de fin de la réservation pour l'utilisateur avec l'ID 1.
SELECT Materiel.Nom, Materiel.Description, Reservation.DateDebutReservation, Reservation.DateFinReservation
FROM Materiel
INNER JOIN Reservation ON Materiel.ID_Materiel = Reservation.Materiel_ID
WHERE Reservation.Utilisateur_ID = 1;

