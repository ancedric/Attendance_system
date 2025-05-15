import db from "../config/db.js";

class Session {
    constructor(sessionRef, name, startTime, sessionDate, nbParticipants, sessionState) {
        this.sessionRef = sessionRef;
        this.name = name;
        this.startTime = startTime;
        this.sessionDate = sessionDate;
        this.nbParticipants = nbParticipants;
        this.sessionState = sessionState;
    }
    // 🟢 Ajouter une session
    static async create(sessionRef, name, sessionDate, startTime, nbParticipants, sessionState) {
        try {
            await db.query(
                "INSERT INTO sessions (sessionRef, name, sessionDate, startTime, nbParticipant, sessionState) VALUES (?, ?, ?, ?, ?, ?)",
                [sessionRef, name, sessionDate, startTime, nbParticipants, sessionState]
            );
            return { sessionRef, message: "Session ajoutée avec succès" };
        } catch (error) {
            throw new Error(error.message);
        }
    }

    // 🔴 Supprimer une session
    static async delete(sessionRef) {
        try {
            await db.query("DELETE FROM sessions WHERE sessionRef = ?", [sessionRef]);
        } catch (error) {
            throw new Error(error.message);
        }
    }
    //Récupérer les types de sessions
    static async getAllTypes() {
        return new Promise((resolve, reject)=>{{
            const sql = "SELECT * FROM sessionType"
            if (!db || !db.query){
                console.error("La connexion à la base de données n'est pas valide.")
                return reject(new Error("Problème de connexion à la base de données."))
            }
            db.query(sql, (err, res)=>{
                if(err){
                    return reject(new Error("SQL error: " + err.message))
                } 
                if(res.length === 0) return reject(new Error("No session found"))
                if(!res) {
                    console.error("Erreur: La requête n'a pas retourné de résultat.")
                    return reject(new Error("SQL request failed."))
                }
                if (res){
                    console.log("Résultat de la requête : ", res)
                    resolve(res)
                }
            })
        }})
    }
    // 🔵 Récupérer toutes les sessions
    static async getAll() {
        console.log("Entrée dans la fonction getAll de sessions")
        return new Promise((resolve, reject)=>{{
            const sql = "SELECT * FROM sessions"
            db.query(sql, (err, res)=>{
                if(err){
                    return reject(new Error("SQL error: " + err.message))
                } 
                if(res.length === 0) return reject(new Error("No session found"))
                console.log(res)
                    resolve(res[0])
            })
        }})
    }

    //Récupérer une session spécifique
    static async getByRef(ref) {
        return new Promise((resolve, reject)=>{{
            const sql = "SELECT * FROM sessions WHERE sessionRef = ?"
            db.query(sql, [ref], (err, res)=>{
                if(err){
                    return reject(new Error("SQL error: " + err.message))
                } 
                if(res.length === 0) return reject(new Error("No session found"))
                console.log(res[0])
                    resolve(res[0])
            })
        }})
    }

    // 🟣 Récupérer les 5 dernières sessions
    static async getLastFive() {
        return new Promise((resolve, reject)=>{{
            const sql = "SELECT * FROM sessions ORDER BY sessionDate DESC LIMIT 5"
            if (!db || !db.query){
                console.error("La connexion à la base de données n'est pas valide.")
                return reject(new Error("Problème de connexion à la base de données."))
            }
            db.query(sql, (err, res)=>{
                console.log("Requête exécutée")
                if(err){
                    return reject(new Error("SQL error: " + err.message))
                } 
                if(res.length === 0) return reject(new Error("No session found"))
                if(!res) {
                    console.error("Erreur: La requête n'a pas retourné de résultat.")
                    return reject(new Error("SQL request failed."))
                }
                if (res){
                    console.log("Résultat de la requête : ", res)
                    resolve(res)
                }
            })
        }})
    }

    // 🟠 Récupérer le nombre de participants d'une session spécifique
    static async getNbParticipants(sessionRef) {
        try {
            const [result] = await db.query("SELECT nbParticipant FROM sessions WHERE sessionRef = ?", [sessionRef]);
            return result.length > 0 ? result[0].nbParticipants : null;
        } catch (error) {
            throw new Error(error.message);
        }
    }

    // 🟡 Modifier le sessionState d'une session spécifique
    static async updateState(sessionRef, newState) {
        try {
            await db.query("UPDATE sessions SET sessionState = ? WHERE sessionRef = ?", [newState, sessionRef]);
        } catch (error) {
            throw new Error(error.message);
        }
    }

    // 🟤 Récupérer les sessions ayant un même name
    static async getByName(name) {
        try {
            const [result] = await db.query("SELECT * FROM sessions WHERE name = ?", [name]);
            return result;
        } catch (error) {
            throw new Error(error.message);
        }
    }
}

export default Session;