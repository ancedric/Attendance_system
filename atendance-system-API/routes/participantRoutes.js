import express from "express"
import Participant from "../models/participant.js"

const participantRouter = express.Router();

// 🟢 Route : Ajouter un participant
participantRouter.post("/add-participant", async (req, res) => {
    const { partRef, userRef, sessionRef, comingTime, quitTime } = req.body;

    try {
        const newParticipant = await Participant.create(partRef, userRef, sessionRef, comingTime, quitTime);
        res.status(201).json(newParticipant);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 🔵 Route : Récupérer un participant spécifique
participantRouter.get("/get-participant/:userRef", async (req, res) => {
    const { userRef } = req.params;

    try {
        const participant = await Participant.getByRef(userRef);
        if (!participant) return res.status(404).json({ error: "Participant non trouvé" });
        res.status(200).json(participant);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 🟣 Route : Récupérer tous les participants
participantRouter.get("/get-participants", async (req, res) => {
    try {
        const participants = await Participant.getAll();
        res.status(200).json(participants);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 🟡 Route : Modifier l'heure de départ (quitTime) d'un participant
participantRouter.put("/update-departure/:partRef", async (req, res) => {
    const { partRef } = req.params;
    const { newQuitTime } = req.body;

    try {
        const updatedParticipant = await Participant.updateQuitTime(partRef, newQuitTime);
        res.status(200).json(updatedParticipant);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 🔴 Route : Supprimer un participant
participantRouter.delete("/delete-participant/:partRef", async (req, res) => {
    const { partRef } = req.params;

    try {
        await Participant.delete(partRef);
        res.status(200).json({ message: "Participant supprimé avec succès" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

export default participantRouter;