import db from '../config/db.js' // Connexion MySQL
import bcrypt from 'bcrypt'

export default class User {
    constructor(userRef, firstName, lastName, email, password) {
        this.userRef = userRef;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
    }

    // Ajouter un utilisateur
    static async create({ firstName, lastName, email, password }) {
        const userRef = `USER_${Date.now()}`;
        const hashedPassword = await bcrypt.hash(password, 10);

        return new Promise((resolve, reject) => {
            db.query(
                'INSERT INTO users (userRef, firstName, lastName, email, password) VALUES (?, ?, ?, ?, ?)',
                [userRef, firstName, lastName, email, hashedPassword],
                (err, result) => {
                    if (err) return reject(err);
                    resolve(userRef);
                }
            );
        });
    }

    // Récupérer un utilisateur par son ref
    static findByRef(userRef) {
        return new Promise((resolve, reject) => {
            db.query('SELECT * FROM users WHERE userRef = ?', [userRef], (err, results) => {
                if (err) return reject(err);
                resolve(results.length ? results[0] : null);
            });
        });
    }
    
    //Récupérer tous les utilisateurs
    static findAll() {
        return new Promise((resolve, reject) => {
            db.query('SELECT * FROM users', (err, results) => {
                if (err) return reject(err);
                resolve(results.length ? results[0] : null);
            });
        });
    }

    // Récupérer un utilisateur par email
    static findByEmail(email) {
        return new Promise((resolve, reject) => {
            db.query('SELECT * FROM users WHERE email = ?', [email], (err, results) => {
                if (err) return reject(err);
                resolve(results.length ? results[0] : null);
            });
        });
    }

    // Mettre à jour le mot de passe
    static async updatePassword(email, newPassword) {
        const hashedPassword = await bcrypt.hash(newPassword, 10);
        return new Promise((resolve, reject) => {
            db.query('UPDATE users SET password = ? WHERE email = ?', [hashedPassword, email], (err, result) => {
                if (err) return reject(err);
                resolve(result.affectedRows > 0);
            });
        });
    }

    // Supprimer un utilisateur
    static delete(userRef) {
        return new Promise((resolve, reject) => {
            db.query('DELETE FROM users WHERE userRef = ?', [userRef], (err, result) => {
                if (err) return reject(err);
                resolve(result.affectedRows > 0);
            });
        });
    }
}