-- Création de la table Matériel
CREATE TABLE Materiel (
    -- Identifiant du matériel, clé primaire avec auto-incrémentation
    ID_Materiel INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    -- Nom du matériel
    Nom VARCHAR(100),
    -- Description du matériel
    Description VARCHAR(255),
    -- Quantité disponible du matériel
    QuantiteDisponible INT,
    -- Etat du matériel (nouveau, utilisé, endommagé, etc.)
    Etat VARCHAR(50),
    -- Emplacement physique du matériel (bâtiment, salle, etc.)
    Emplacement VARCHAR(100)
);

-- Insertion de données dans la table Matériel
INSERT INTO Materiel (Nom, Description, QuantiteDisponible, Etat, Emplacement)
VALUES
    -- Données d'exemple pour différents matériels
    ('Ordinateur de bureau', 'PC de bureau Dell OptiPlex 7070', 10, 'Neuf', 'Salle C101'),
    ('Projecteur', 'Projecteur BenQ TH683', 2, 'Très bon état', 'Auditorium'),
    ('Tablette numérique', 'Tablette Apple iPad Pro 12.9"', 5, 'Neuf', 'Salle D202'),
    ('Caméra vidéo', 'Caméra vidéo Sony FDR-AX53', 3, 'Bon état', 'Studio audiovisuel'),
    ('Microphone sans fil', 'Microphone sans fil Shure SM58', 7, 'Neuf', 'Salle de musique'),
    ('Casque de réalité virtuelle', 'Casque VR Oculus Rift S', 4, 'Neuf', 'Laboratoire VR'),
    ('Imprimante 3D', 'Imprimante 3D Prusa i3 MK3S', 1, 'Neuf', 'Atelier de prototypage'),
    ('Scanner 3D', 'Scanner 3D Artec Eva', 2, 'Occasion', 'Laboratoire de design'),
    ('Drone', 'Drone DJI Phantom 4 Pro', 3, 'Bon état', 'Espace extérieur'),
    ('Haut-parleur', 'Haut-parleur Bose SoundLink Revolve', 6, 'Neuf', 'Salle de repos');

