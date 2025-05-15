import db from "../config/db.js"

class Schedule {
    constructor(schedRef, sessionRef, sessionName, sessionDate, sessionStart) {
        this.schedRef = schedRef;
        this.sessionRef = sessionRef;
        this.sessionName = sessionName;
        this.sessionDate = sessionDate;
        this.sessionStart = sessionStart;
    }

    // 🟢 Ajouter un schedule
    static async create(schedRef, sessionRef, sessionName, sessionDate, sessionStart) {
        try {
            await db.query(
                "INSERT INTO schedule (schedRef, sessionRef, sessionName, sessionDate, sessionStart) VALUES (?, ?, ?, ?, ?)",
                [schedRef, sessionRef, sessionName, sessionDate, sessionStart]
            );
            return { schedRef, message: "Programmation ajoutée avec succès" };
        } catch (error) {
            throw new Error(error.message);
        }
    }

    // 🔴 Supprimer un schedule
    static async delete(schedRef) {
        try {
            await db.query("DELETE FROM schedule WHERE schedRef = ?", [schedRef]);
            return { message: "Programmation supprimée avec succès" };
        } catch (error) {
            throw new Error(error.message);
        }
    }

    // 🟣 Récupérer les 5 dernières programmations
    static async getLastFive() {
        try {
            const [result] = await db.query(
                "SELECT * FROM schedule ORDER BY sessionDate DESC, sessionStart DESC LIMIT 5"
            );
            return result;
        } catch (error) {
            throw new Error(error.message);
        }
    }

    // 🟡 Modifier une programmation
    static async update(schedRef, newSessionRef, newSessionName, newSessionDate, newSessionStart) {
        try {
            await db.query(
                "UPDATE schedule SET sessionRef = ?, sessionName = ?, sessionDate = ?, sessionStart = ? WHERE schedRef = ?",
                [newSessionRef, newSessionName, newSessionDate, newSessionStart, schedRef]
            );
            return { schedRef, message: "Programmation mise à jour avec succès" };
        } catch (error) {
            throw new Error(error.message);
        }
    }
}

export default Schedule;