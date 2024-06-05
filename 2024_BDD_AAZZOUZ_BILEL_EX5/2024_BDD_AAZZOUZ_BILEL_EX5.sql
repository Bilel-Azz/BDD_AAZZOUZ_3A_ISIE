-- Cette requête décrémente la quantité disponible du matériel avec comme IdentifiantMateriel = 1
-- Avant l'update, la quantité était de 5, maintenant elle sera de 4
UPDATE Materiel
SET QuantiteDisponible = QuantiteDisponible - 1
WHERE ID_Materiel = 1;
