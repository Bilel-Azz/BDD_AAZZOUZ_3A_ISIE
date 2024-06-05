-- Cette requête compte le nombre total de réservations.
-- La clause WHERE filtre les réservations en fonction de la date de début de la réservation.
-- Seules les réservations effectuées entre le 19 mars 2024 et le 21 mars 2024 sont incluses.
SELECT COUNT(*) AS TotalReservations
FROM Reservation
WHERE DateDebutReservation BETWEEN '2024-03-19' AND '2024-03-21';

-- Cette requête compte le nombre d'utilisateurs distincts qui ont effectué une réservation.
SELECT COUNT(DISTINCT Utilisateur_ID) AS NombreUtilisateurs
FROM Reservation;
