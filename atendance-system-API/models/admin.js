import db from '../config/db.js' 

class Administrator {
    constructor(adminRef, firstName, lastName, email, password, privilege = "admin") {
        this.adminRef = adminRef;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
        this.privilege = privilege;
    }

    static async create(firstName, lastName, email, password) {
        const adminRef = `ADMIN-${Date.now()}`;
        const privilege = "administrator";
        
        try {
            await db.query(
                "INSERT INTO administrator (adminRef, FirstName, LastName, Email, Password, Privilege) VALUES (?, ?, ?, ?, ?, ?)",
                [adminRef, firstName, lastName, email, password, privilege]
            );
            return { adminRef, message: "Administrateur créé avec succès" };
        } catch (error) {
            throw new Error(error.message);
        }
    }

    static async login(email, password) {
        return new Promise((resolve, reject)=>{{
            const sql = "SELECT * FROM administrator WHERE Email = ?"
            db.query(sql, [email], (err, res)=>{
                if(err){
                    return reject(new Error("SQL error: " + err.message))
                } 
                if(res.length === 0) return reject(new Error("Incorrect identifiants"))
                resolve(res[0])
            })
        }})
    }

    static async getAll() {
        try {
            const [result] = await db.query("SELECT * FROM administrator");
            return result;
        } catch (error) {
            throw new Error(error.message);
        }
    }

    //récupérerer l'administrateur par son email
    static findByEmail(email, password) {
        return new Promise((resolve, reject) => {
            db.query('SELECT * FROM administrator WHERE email = ? AND password = ?', [email, password], (err, results) => {
                if (err) return reject(err);
                //resolve(results.length ? results[0] : null);
                return results[0]
            });
        });
    }

    static async getByRef(adminRef) {
        try {
            const [result] = await db.query("SELECT * FROM administrator WHERE adminRef = ?", [adminRef]);
            return result.length > 0 ? result[0] : null;
        } catch (error) {
            throw new Error(error.message);
        }
    }

    static async delete(adminRef) {
        try {
            await db.query("DELETE FROM administrator WHERE adminRef = ?", [adminRef]);
        } catch (error) {
            throw new Error(error.message);
        }
    }

    static async updatePrivilege(adminRef, newPrivilege) {
        try {
            await db.query("UPDATE administrator SET privilege = ? WHERE adminRef = ?", [newPrivilege, adminRef]);
        } catch (error) {
            throw new Error(error.message);
        }
    }
}

export default Administrator;