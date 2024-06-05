-- Création de la table Disponibilite
CREATE TABLE Disponibilite (
    ID_Disponibilite INT PRIMARY KEY NOT NULL AUTO_INCREMENT, -- Identifiant de la disponibilité
    ID_Materiel INT, -- Identifiant du matériel, clé étrangère vers Materiel
    DateDebut DATE, -- Date de début de la disponibilité 
    DateFin DATE, -- Date de fin de la disponibilité
    FOREIGN KEY (ID_Materiel) REFERENCES Materiel(ID_Materiel) -- Clé étrangère vers la table Materiel
);

-- Ajout de la colonne ID_Disponibilite dans la table Reservation
ALTER TABLE Reservation -- Ajout de la colonne ID_Disponibilite
ADD COLUMN ID_Disponibilite INT, -- Identifiant de la disponibilité, clé étrangère vers Disponibilite
ADD FOREIGN KEY (ID_Disponibilite) REFERENCES Disponibilite(ID_Disponibilite); -- Clé étrangère vers la table Disponibilite

-- Déclencheur avant l'insertion pour vérifier la disponibilité du matériel
DELIMITER //

CREATE TRIGGER Before_Reservation_Insert    -- Nom du déclencheur
BEFORE INSERT ON Reservation              -- Déclencheur avant l'insertion dans la table Reservation
FOR EACH ROW                       -- Pour chaque ligne insérée
BEGIN                        -- Début du bloc
    DECLARE AvailCount INT;           -- Variable pour stocker le nombre de disponibilités
    SELECT COUNT(*)  
    INTO AvailCount  -- Stocker le nombre de disponibilités
    FROM Disponibilite  -- 
    WHERE ID_Materiel = NEW.Materiel_ID
    AND NEW.DateDebutReservation BETWEEN DateDebut AND DateFin  -- Vérifier si la date de début est entre la date de début et de fin
    AND NEW.DateFinReservation BETWEEN DateDebut AND DateFin;  -- Vérifier si la date de fin est entre la date de début et de fin
    
    IF AvailCount = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Le matériel n''est pas dispo pour cette période.';
    END IF;
END//

DELIMITER ;

-- Déclencheur avant la mise à jour pour vérifier la disponibilité du matériel

DELIMITER $$

CREATE TRIGGER Before_Disponibilite_Update  -- Nom du déclencheur
BEFORE UPDATE ON Disponibilite          -- Déclencheur avant la mise à jour dans la table Disponibilite
FOR EACH ROW                     -- Pour chaque ligne mise à jour
BEGIN
    DECLARE ResCount INT;         -- Variable pour stocker le nombre de réservations
    SELECT COUNT(*) INTO ResCount FROM Reservation     -- Compter le nombre de réservations
    WHERE Materiel_ID = NEW.ID_Materiel    -- Vérifier les réservations pour le matériel mis à jour
    AND (NEW.DateDebut BETWEEN DateDebutReservation AND DateFinReservation    -- Vérifier si la nouvelle période de disponibilité se chevauche avec des réservations existantes
        OR NEW.DateFin BETWEEN DateDebutReservation AND DateFinReservation    
        OR (NEW.DateDebut <= DateDebutReservation AND NEW.DateFin >= DateFinReservation));
    
    IF ResCount > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La nouvelle période de disponibilité se chevauche avec des réservations existantes.';
    END IF;
END $$

DELIMITER ;


-- Déclencheur avant la suppression pour vérifier les réservations associées



DELIMITER $$

CREATE TRIGGER Before_Disponibilite_Delete   -- Nom du déclencheur
BEFORE DELETE ON Disponibilite        -- Déclencheur avant la suppression dans la table Disponibilite
FOR EACH ROW
BEGIN                    -- Pour chaque ligne supprimée
    DECLARE ResCount INT;     -- Variable pour stocker le nombre de réservations
    SELECT COUNT(*) INTO ResCount FROM Reservation   -- Compter le nombre de réservations
    WHERE ID_Disponibilite = OLD.ID_Disponibilite;   -- Vérifier les réservations associées à la disponibilité supprimée
    
    IF ResCount > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Impossible de supprimer cette disponibilité car elle est associée à des réservations existantes.';
    END IF;
END $$

DELIMITER ;


-- Tests pour vérifier les conditions

-- Test 1: Ajouter une réservation valide
-- Cette réservation doit être valide car elle est dans la période de disponibilité du matériel
INSERT INTO Reservation (DateReservation, DateDebutReservation, DateFinReservation, Utilisateur_ID, Materiel_ID, StatutReservation, ID_Disponibilite)
VALUES ('2024-03-05', '2024-03-06', '2024-03-07', 1, 1, 'confirmée', 1);

-- Test 2: Ajouter une réservation invalide
-- Cette réservation doit échouer car elle chevauche une réservation existante
INSERT INTO Reservation (DateReservation, DateDebutReservation, DateFinReservation, Utilisateur_ID, Materiel_ID, StatutReservation, ID_Disponibilite)
VALUES ('2024-03-05', '2024-03-07', '2024-03-09', 1, 1, 'confirmée', 1);

-- Test 3: Ajouter une réservation avec une période en dehors de la disponibilité
-- Cette réservation doit échouer car elle est en dehors de la période de disponibilité du matériel
INSERT INTO Reservation (DateReservation, DateDebutReservation, DateFinReservation, Utilisateur_ID, Materiel_ID, StatutReservation, ID_Disponibilite)
VALUES ('2024-03-05', '2024-02-25', '2024-03-01', 1, 1, 'confirmée', 1);

-- Test 4: Ajouter une réservation pour un autre matériel disponible
-- Cette réservation doit être valide car elle est dans la période de disponibilité d'un autre matériel
INSERT INTO Reservation (DateReservation, DateDebutReservation, DateFinReservation, Utilisateur_ID, Materiel_ID, StatutReservation, ID_Disponibilite)
VALUES ('2024-03-05', '2024-03-06', '2024-03-07', 2, 2, 'confirmée', NULL);

-- Test 5: Modifier une période de disponibilité (valide)
-- Cette modification doit réussir car elle ne chevauche aucune réservation existante
UPDATE Disponibilite SET DateDebut = '2024-03-02', DateFin = '2024-03-10' WHERE ID_Disponibilite = 1;

-- Test 6: Modifier une période de disponibilité (chevauchement)
-- Cette modification doit échouer car elle chevauche des réservations existantes
UPDATE Disponibilite SET DateDebut = '2024-03-05', DateFin = '2024-03-15' WHERE ID_Disponibilite = 1;

-- Test 7: Supprimer une période de disponibilité associée à des réservations
-- Cette suppression doit échouer car la disponibilité est associée à des réservations existantes
DELETE FROM Disponibilite WHERE ID_Disponibilite = 1;

-- Test 8: Supprimer une période de disponibilité sans réservations associées
-- Cette suppression doit réussir car il n'y a pas de réservations associées
DELETE FROM Disponibilite WHERE ID_Disponibilite = 2;
