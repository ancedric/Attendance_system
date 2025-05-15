import db from "../config/db.js"

class Participant {
    constructor(partRef, userRef, sessionRef, comingTime, quitTime) {
        this.partRef = partRef;
        this.userRef = userRef;
        this.sessionRef = sessionRef;
        this.comingTime = comingTime;
        this.quitTime = quitTime;
    }

    // 🟢 Ajouter un participant
    static async create(partRef, userRef, sessionRef, comingTime, quitTime = null) {
        try {
            await db.query(
                "INSERT INTO participants (partRef, userRef, sessionRef, comingTime, quitTime) VALUES (?, ?, ?, ?, ?)",
                [partRef, userRef, sessionRef, comingTime, quitTime]
            );
            return { partRef, message: "Participant ajouté avec succès" };
        } catch (error) {
            throw new Error(error.message);
        }
    }

    // 🔵 Récupérer un participant spécifique
    static async getByRef(userRef) {
        try {
            const [result] = await db.query("SELECT * FROM participants WHERE userRef = ?", [userRef]);
            return result.length > 0 ? result[0] : null;
        } catch (error) {
            throw new Error(error.message);
        }
    }

    // 🟣 Récupérer tous les participants
    static async getAll() {
        try {
            const [result] = await db.query("SELECT * FROM participants");
            return result;
        } catch (error) {
            throw new Error(error.message);
        }
    }

    // 🟡 Modifier l'heure de départ (quitTime) d'un participant
    static async updateQuitTime(partRef, newQuitTime) {
        try {
            await db.query("UPDATE participants SET quitTime = ? WHERE partRef = ?", [newQuitTime, partRef]);
            return { partRef, message: "Heure de départ mise à jour" };
        } catch (error) {
            throw new Error(error.message);
        }
    }

    // 🔴 Supprimer un participant
    static async delete(partRef) {
        try {
            await db.query("DELETE FROM participants WHERE partRef = ?", [partRef]);
            return { message: "Participant supprimé avec succès" };
        } catch (error) {
            throw new Error(error.message);
        }
    }
}

export default Participant;