import dotenv from "dotenv"
dotenv.config()
import express from 'express'
import jwt from 'jsonwebtoken'
import User from '../models/user.js'
import bcrypt from 'bcrypt'

const userRouter = express.Router();
const secretKey = process.env.JWT_SECRET

// Inscription (Signup)
userRouter.post('/signup', async (req, res) => {
    try {
        const userRef = await User.create(req.body);
        res.status(201).json({ message: "Utilisateur inscrit", userRef });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Connexion (Signin)
userRouter.post('/signin', async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.findByEmail(email);

        if (!user || !(await bcrypt.compare(password, user.password))) {
            return res.status(401).json({ message: "Email ou mot de passe incorrect" });
        }

        const token = jwt.sign({ userRef: user.userRef }, secretKey, { expiresIn: "1h" });
        res.json({ message: "Connexion réussie", token, user });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Déconnexion (Logout) - côté client (effacement du token)
userRouter.post('/logout', (req, res) => {
    res.json({ message: "Déconnexion réussie" });
});

// Récupérer un utilisateur par sa référence
userRouter.get('/get-user/:userRef', async (req, res) => {
    try {
        const user = await User.findByRef(req.params.userRef);
        if (!user) return res.status(404).json({ message: "Utilisateur non trouvé" });

        res.json(user);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Récupérer tous les utilisateurs
userRouter.get('/get-users', async (req, res) => {
    try {
        const user = await User.findAll();
        if (!user) return res.status(404).json({ message: "Utilisateur non trouvé" });

        res.json(user);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Modifier le mot de passe d'un utilisateur (via email)
userRouter.put('/user/update-password', async (req, res) => {
    try {
        const success = await User.updatePassword(req.body.email, req.body.newPassword);
        if (!success) return res.status(404).json({ message: "Utilisateur non trouvé" });

        res.json({ message: "Mot de passe mis à jour avec succès" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Supprimer un utilisateur
userRouter.delete('/user/delete/:userRef', async (req, res) => {
    try {
        const success = await User.delete(req.params.userRef);
        if (!success) return res.status(404).json({ message: "Utilisateur non trouvé" });

        res.json({ message: "Utilisateur supprimé" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

export default userRouter;