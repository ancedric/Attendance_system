import dotenv from 'dotenv';

dotenv.config(); 

import mysql from 'mysql2';
import fs from 'fs';

// Récupérez les informations de connexion depuis les variables d'environnement
const dbConfig = {
  host: process.env.DB_HOST || 'smart-ats-db-smart-ats.b.aivencloud.com', // Utilisez une variable d'env pour l'hôte
  port: process.env.DB_PORT || 12825, // Utilisez une variable d'env pour le port
  user: process.env.DB_USER || 'avnadmin', // Utilisez une variable d'env pour l'utilisateur
  password: process.env.DB_PASSWORD || 'votre_mot_de_passe', // Utilisez une variable d'env sécurisée
  database: process.env.DB_NAME || 'defaultdb', // Utilisez une variable d'env pour le nom de la base de données
  ssl: {
    mode: 'REQUIRED',
    // Assurez-vous d'avoir le certificat CA. Vous pouvez le télécharger depuis Aiven.
    ca: fs.readFileSync('ca.pem'), // Chemin vers le certificat ou variable d'env
  },
  namedPlaceholders: true,
  connectTimeout: 30000,
};

// Créer une connexion
const db = mysql.createConnection(dbConfig);

// Établir la connexion
db.connect((err) => {
  if (err) {
    console.error('Erreur de connexion à la base de données :', err);
    return;
  }
  console.log('Connecté à la base de données MySQL sur Aiven !');
});

// Exécuter une requête
export const query = (sql, params) => {
  return new Promise((resolve, reject) => {
    db.query(sql, params, (err, results) => {
      if (err) {
        console.error('Erreur lors de l\'exécution de la requête :', err);
        reject(err);
      } else {
        resolve(results);
      }
    });
  });
};

// Exemple d'utilisation de la fonction executeQuery
async function fetchSessions() {
  try {
    const sessions = await query('SELECT * FROM sessions', []);
    console.log('Sessions :', sessions);
  } catch (error) {
    // L'erreur est déjà enregistrée dans executeQuery, mais vous pouvez la gérer plus loin si nécessaire
    console.error('Erreur lors de la récupération des sessions :', error);
  }
}

// Appeler la fonction fetchSessions
//fetchSessions(); // Décommentez ceci pour exécuter la requête

// Exportez la connexion pour pouvoir l'utiliser dans d'autres modules
export default db;
