import express from"express"
import Administrator from"../models/admin.js"

const adminRouter = express.Router();
// 🟢 Route : Inscription d'un administrateur
adminRouter.post("/signup", async (req, res) => {
    const firstName = req.body.FirstName
    const lastName = req.body.LastName 
    const email = req.body.Email
    const password = req.body.Password

    try {
        const newAdmin = await Administrator.create(firstName, lastName, email, password);
        res.status(201).json(newAdmin);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 🔵 Route : Connexion d'un administrateur
adminRouter.post('/signin', async (req, res) => {
    try {
        const email = req.body.Email
        const password = req.body.Password;

        const admin = await Administrator.login(email, password);

        if (!admin) {
            return res.status(401).json({ message: "Email ou mot de passe incorrect" });
        }
        console.log(admin)
        res.json({ message: "Connexion réussie", admin });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 🟣 Route : Récupérer tous les administrateurs
adminRouter.get("/get-admins", async (req, res) => {
    try {
        const admins = await Administrator.getAll();
        res.status(200).json(admins);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 🟠 Route : Récupérer un administrateur par référence
adminRouter.get("/get-admin/:adminRef", async (req, res) => {
    const { adminRef } = req.params;

    try {
        const admin = await Administrator.getByRef(adminRef);
        if (!admin) return res.status(404).json({ error: "Administrateur non trouvé" });
        res.status(200).json(admin);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 🔴 Route : Supprimer un administrateur
adminRouter.delete("/delete-admin/:adminRef", async (req, res) => {
    const { adminRef } = req.params;

    try {
        await Administrator.delete(adminRef);
        res.status(200).json({ message: "Administrateur supprimé avec succès" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 🟡 Route : Modifier le privilège d’un administrateur
adminRouter.put("/set-privilege/:adminRef", async (req, res) => {
    const { adminRef } = req.params;
    const { newPrivilege } = req.body;

    try {
        await Administrator.updatePrivilege(adminRef, newPrivilege);
        res.status(200).json({ message: "Privilège mis à jour avec succès" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

export default adminRouter;