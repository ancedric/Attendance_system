import express from "express"
import Session from "../models/session.js"

const sessionRouter = express.Router();

// 🟢 Route : Ajouter une session
sessionRouter.post("/add-session", async (req, res) => {
    const { Ref, Name,  SessionDate, StartTime, NbParticipants, State } = req.body;
    try {
        console.log("received data: ", Ref, Name,  SessionDate, StartTime, NbParticipants, State)
        const newSession = await Session.create(Ref, Name, SessionDate, StartTime, NbParticipants, State);
        res.status(201).json(newSession);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 🔴 Route : Supprimer une session
sessionRouter.delete("/delete-sesion/:sessionRef", async (req, res) => {
    const { sessionRef } = req.params;

    try {
        await Session.delete(sessionRef);
        res.status(200).json({ message: "Session supprimée avec succès" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 🔵 Route : Récupérer toutes les sessions
sessionRouter.get("/get-sessions", async (req, res) => {
    try {
        const sessions = await Session.getAll();
        res.status(200).json(sessions);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

//Route pour récupérer tous les types de session
sessionRouter.get("/get-sessionTypes", async (req, res) => {
    try {
        const sessionTypes = await Session.getAllTypes();
        res.status(200).json(sessionTypes); 
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 🟣 Route : Récupérer les 5 dernières sessions
sessionRouter.get("/get-latest-sessions", async (req, res) => {
    console.log("route activée")
    try {
        const lastFiveSessions = await Session.getLastFive();
        console.log("dernières sessions: ", lastFiveSessions)
        res.status(200).json(lastFiveSessions);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 🟠 Route : Récupérer le nombre de participants d'une session spécifique
sessionRouter.get("/get-participant-number/:sessionRef", async (req, res) => {
    const { sessionRef } = req.params;

    try {
        const nbParticipants = await Session.getNbParticipants(sessionRef);
        if (nbParticipants === null) return res.status(404).json({ error: "Session non trouvée" });
        res.status(200).json({ sessionRef, nbParticipants });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 🟡 Route : Modifier le sessionState d'une session spécifique
sessionRouter.put("/set-state/:sessionRef", async (req, res) => {
    const { sessionRef } = req.params;
    const { newState } = "closed"

    try {
        await Session.updateState(sessionRef, newState);
        res.status(200).json({ message: "SessionState mis à jour avec succès" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 🟤 Route : Récupérer les sessions ayant un même name
sessionRouter.get("/get-sessions-name/:name", async (req, res) => {
    const { name } = req.params;

    try {
        const sessions = await Session.getByName(name);
        res.status(200).json(sessions);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 🟤 Route : Récupérer une session spécifique
sessionRouter.get("/get-session/:sessionRef", async (req, res) => {
    const { sessionRef } = req.params;

    try {
        const sessions = await Session.getByRef(sessionRef);
        res.status(200).json(sessions);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

export default sessionRouter;