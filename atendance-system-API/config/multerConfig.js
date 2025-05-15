import path, { dirname } from 'path';
import multer from 'multer';
import fs from 'fs';
import { fileURLToPath } from "url";

//options de stockage pour multer
export const storage = multer.diskStorage({
    destination: 'frontend/src/assets/usersMedias',
    filename: (req, file, cb) => {
        cb(null, file.originalname)
    },
})

// Middleware de téléchargement avec Multer
export const upload = multer({ storage : storage });

// Chemin du module actuel
export const __filename = fileURLToPath(import.meta.url);
// Répertoire parent en utilisant path et __filename
export const __dirname = dirname(__filename);
