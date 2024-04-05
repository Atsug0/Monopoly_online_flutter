Bienvenue au Mono Paul Hi ! 

Prérequis : 
  - Installer flutter
  - Installer NodeJS
  - Installer MariaDB

Etapes de lancement :
  - Lancement du back avec la commande "npm start"
  - Lancement du front avec la commande "flutter run"
    
Tests : 
  - Pour l'API :
    - Lancement du swagger pour les tests avec la commande "npm run swagger"
  - Pour les Tests Unitaires (TU) :
    -Lancement des TU du front avec la commande "flutter test"
    
Architecture :
  - Deux répertoires : 
    - Front. Dans le repertoire lib :
      - Modele : Objets nécessaires au bon fonctionnement (cartes, joueurs, lobby)
      - Vue : Aspect visuel de l'application
      - Controller : règles du jeu , requêtes vers le serveur et gestion du socket
    - Back :
      - Server.js : Initialisation du serveur et gestion des sockets
      - dbconfig.js : Initialise la Base de données, utilisation de procédure
      - routes.js : Repertorie toutes les routes disponibles
      
