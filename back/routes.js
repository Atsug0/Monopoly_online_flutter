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


router.post('/registeruser', (req, res) => {
    const sqlQuery = `CALL registerUser(?,?,?)`;
    const { username, email, password } = req.body;
    db.query(sqlQuery,[username,email,password],(err,results)=>{
        if (err) throw err;
        res.status(200).send("User created !");
    });
  });

// Authentifie un utilisateur 
router.post('/authenticateuser',(req,res)=>{
  const sqlQuery = `CALL authenticateUser(?,?)`;
  const {input,password} = req.body;
  db.query(sqlQuery,[input,password],(err,results)=>{
    if (err) {
      res.status(500).send("Authentification failed")
    }else{
    res.status(200).send(results);
    }
  });
});
 
// get username avec son id
router.get('/getinfosuserwithid', (req, res) => {
    const id_params = req.query.id;
    db.query(`SELECT * FROM User WHERE user_id=${id_params}`, (err, results) => {
      if (err) {
        return res.status(500).send("Internal Server Error ! ");
      }
      const user = results[0];
      if (!user) {
        return res.status(404).send("User not found ! ");
      }
        res.status(200).json({username: user.username });
      });
  });