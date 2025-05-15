import express from "express"
import Schedule from "../models/schedule.js"

const scheduleRouter = express.Router();

// 🟢 Route : Ajouter un schedule
scheduleRouter.post("/", async (req, res) => {
    const { schedRef, sessionRef, sessionName, sessionDate, sessionStart } = req.body;

    try {
        const newSchedule = await Schedule.create(schedRef, sessionRef, sessionName, sessionDate, sessionStart);
        res.status(201).json(newSchedule);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 🔴 Route : Supprimer un schedule
scheduleRouter.delete("/:schedRef", async (req, res) => {
    const { schedRef } = req.params;

    try {
        await Schedule.delete(schedRef);
        res.status(200).json({ message: "Programmation supprimée avec succès" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 🟣 Route : Récupérer les 5 dernières programmations
scheduleRouter.get("/last-five", async (req, res) => {
    try {
        const schedules = await Schedule.getLastFive();
        res.status(200).json(schedules);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// 🟡 Route : Modifier une programmation
scheduleRouter.put("/:schedRef", async (req, res) => {
    const { schedRef } = req.params;
    const { newSessionRef, newSessionName, newSessionDate, newSessionStart } = req.body;

    try {
        const updatedSchedule = await Schedule.update(schedRef, newSessionRef, newSessionName, newSessionDate, newSessionStart);
        res.status(200).json(updatedSchedule);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

export default scheduleRouter;