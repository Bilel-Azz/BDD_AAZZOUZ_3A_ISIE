-- Création de la table Utilisateur
CREATE TABLE Utilisateur (
    -- Identifiant de l'utilisateur, clé primaire avec auto-incrémentation
    Id_user INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    -- Nom de l'utilisateur
    Nom VARCHAR(50),
    -- Prénom de l'utilisateur
    Prenom VARCHAR(50),
    -- Adresse email de l'utilisateur
    Email VARCHAR(100),
    -- Numéro étudiant de l'utilisateur
    Idetu VARCHAR(20),
    -- Statut de l'utilisateur (étudiant, enseignant, etc.)
    Statut VARCHAR(50)
);

-- Insertion de données dans la table Utilisateur
INSERT INTO Utilisateur (Nom, Prenom, Email, Idetu, Statut)
VALUES
    -- Données d'exemple pour des utilisateurs
    ('Lemoine', 'Alice', 'alice.lemoine@example.com', '32001688t', 'etudiant'),
    ('Bernard', 'Paul', 'paul.bernard@example.com', '32021688t', 'etudiant'),
    ('Durand', 'Chloé', 'chloe.durand@example.com', '32007888t', 'etudiant'),
    ('Morel', 'Lucas', 'lucas.morel@example.com', '32796881t', 'etudiant'),
    ('Simon', 'Nina', 'nina.simon@example.com', '32011690t', 'etudiant'),
    ('Roux', 'Hugo', 'hugo.roux@example.com', '32001126t', 'etudiant'),
    ('Blanc', 'Léa', 'lea.blanc@example.com', '32001661t', 'etudiant'),
    ('Muller', 'Julien', 'julien.muller@example.com', '32001111t', 'etudiant'),
    ('Fischer', 'Emma', 'emma.fischer@example.com', '32005676t', 'etudiant'),
    ('Schmidt', 'Louis', 'louis.schmidt@example.com', '30101688t', 'etudiant');
