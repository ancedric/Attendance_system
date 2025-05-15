import dotenv from "dotenv"
dotenv.config()

import express from 'express';
import cors from 'cors'
import session from 'express-session';
import userRouter from './routes/userRoutes.js';
import adminRouter from './routes/adminRoutes.js';
import sessionRouter from './routes/sessionRoutes.js';
import participantRouter from './routes/participantRoutes.js';
import scheduleRouter from './routes/scheduleRoutes.js';

const app = express();

app.use(cors());
app.use(express.json());

const port = process.env.PORT || 8082;

// Utiliser les routes
app.use('/user', userRouter);
app.use('/admin', adminRouter);
app.use('/session', sessionRouter);
app.use('/participant', participantRouter);
app.use('/schedule', scheduleRouter);

app.listen(port, () => {
    console.log(`Connected to the server on localhost:${port}`);
})
