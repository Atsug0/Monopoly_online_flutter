//Creation d'un compte utilisateur
//Connexion d'un utilisateur
//Récupération des informations d'un utilisateur
//Modification des informations d'un utilisateur
//Creation d'un lobby
//Rejoindre un lobby
//Supprimer un lobby
//Création d'un joueur
//Récupération des informations d'un joueur ou plusieurs
//Modification des informations d'un joueur ou plusieurs
//Supprimer un joueur ou plusieurs
//Récupération des cartes
//Creation de carte temporaire
//Récupération des cartes temporaires
//Modification de carte temporaire
//Suppression de carte temporaire
//Recuperer une carte chance
//Recuperer une carte communaute
//Recuperer informations d'une partie
//Modification des informations d'une partie
/*
// GET :
router.post('/users', (req, res) => {
    const { username, password, email } = req.body;
  
    // Validation des données
  
    // Hachage du mot de passe
  
    // Exécution de la requête SQL INSERT
  
    // Envoi d'un email de confirmation
  
    res.json({ success: true });
  });
  router.put('/users', (req, res) => {
    const { username, password, email } = req.body;
  
    // Validation des données
  
    // Hachage du mot de passe
  
    // Exécution de la requête SQL INSERT
  
    // Envoi d'un email de confirmation
  
    res.json({ success: true });
  });
    
  router.get('/users/:id', (req, res) => {
    const userId = req.params.id;
  
    // Exécution de la requête SQL SELECT
  
    res.json(results[0]);
  });
  
  router.put('/users/:id', (req, res) => {
  const userId = req.params.id;
  const { username, email } = req.body;

  // Validation des données

  // Exécution de la requête SQL UPDATE

  res.json({ success: true });
});

router.post('/lobbies', (req, res) => {
    const { name, maxPlayers } = req.body;
  
    // Création d'un nouveau lobby
  
    // Exécution de la requête SQL INSERT
  
    res.json({ success: true, lobbyId });
  });

  router.post('/lobbies/:id/join', (req, res) => {
    const lobbyId = req.params.id;
    const userId = req.userId;
  
    // Vérification si le lobby existe et n'est pas plein
  
    // Ajout de l'utilisateur au lobby
  
    // Exécution de la requête SQL UPDATE
  
    res.json({ success: true });
  });

  router.delete('/lobbies/:id', (req, res) => {
    const lobbyId = req.params.id;
  
    // Vérification si le lobby existe et appartient à l'utilisateur
  
    // Exécution de la requête SQL DELETE
  
    res.json({ success: true });
  });

  router.post('/players', (req, res) => {
    const { name, lobbyId } = req.body;
  
    // Création d'un nouveau joueur
  
    // Exécution de la requête SQL INSERT
  
    res.json({ success: true, playerId });
  });

  router.get('/players/:id?', (req, res) => {
    const playerId = req.params.id;
  
    // Si l'ID est spécifié, récupérer un seul joueur
  
    // Sinon, récupérer tous les joueurs
  
    // Exécution de la requête SQL SELECT
  
    res.json(results);
  });

  router.put('/players/:id', (req, res) => {
    const playerId = req.params.id;
    const { name } = req.body;
  
    // Validation des données
  
    // Exécution de la requête SQL UPDATE
  
    res.json({ success: true });
  });

  router.delete('/players/:id', (req, res) => {
    const playerId = req.params.id;
  
    // Vérification si le joueur existe
  
    // Exécution de la requête SQL DELETE
  
    res.json({ success: true });
  });

  router.get('/cartes', (req, res) => {
    // Exécution de la requête SQL SELECT
  
    res.json(results);
  });

  router.post('/cartes/temporaires', (req, res) => {
    const { type, effet } = req.body;
  
    // Création d'une nouvelle carte temporaire
  
    // Exécution de la requête SQL INSERT
  
    res.json({ success: true, carteId });
  });
  router.get('/cartes/temporaires', (req, res) => {
    const { type, effet } = req.body;
  
    // Création d'une nouvelle carte temporaire
  
    // Exécution de la requête SQL INSERT
  
    res.json({ success: true, carteId });
  });

*/