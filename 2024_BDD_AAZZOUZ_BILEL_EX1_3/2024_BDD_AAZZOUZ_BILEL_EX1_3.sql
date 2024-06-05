-- Création de la table Réservation
CREATE TABLE Reservation (
    -- Identifiant de la réservation, clé primaire avec auto-incrémentation
    ID_Reservation INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    -- Date de la réservation
    DateReservation DATE,
    -- Date de début de la réservation
    DateDebutReservation DATE,
    -- Date de fin de la réservation
    DateFinReservation DATE,
    -- Identifiant de l'utilisateur qui réserve, clé étrangère vers Utilisateur
    Utilisateur_ID INT,
    -- Identifiant du matériel réservé, clé étrangère vers Materiel
    Materiel_ID INT,
    -- Statut de la réservation (confirmée, en attente, annulée, etc.)
    StatutReservation VARCHAR(50),
    FOREIGN KEY (Utilisateur_ID) REFERENCES Utilisateur(Id_user),
    FOREIGN KEY (Materiel_ID) REFERENCES Materiel(ID_Materiel)
);

-- Insertion de données dans la table Réservation
INSERT INTO Reservation (DateReservation, DateDebutReservation, DateFinReservation, Utilisateur_ID, Materiel_ID, StatutReservation)
VALUES
    -- Données d'exemple pour des réservations
    ('2024-04-01', '2024-04-03', '2024-04-05', 1, 1, 'confirmée'),
    ('2024-04-02', '2024-04-04', '2024-04-06', 2, 2, 'en attente'),
    ('2024-04-03', '2024-04-05', '2024-04-07', 3, 3, 'confirmée'),
    ('2024-04-04', '2024-04-06', '2024-04-08', 4, 4, 'annulée'),
    ('2024-04-05', '2024-04-07', '2024-04-09', 5, 5, 'confirmée');
