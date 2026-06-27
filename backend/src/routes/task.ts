
import { Router } from "express";
import { auth } from "../middleware/auth.js";  // ← remove "type", auth is a value not a type
import type { AuthRequest } from "../middleware/auth.js";

const taskRouter = Router();  // ← was TaskRouter

taskRouter.post("/", auth, async (req: AuthRequest, res) => {

    try{

    } catch (e){
        res.status(500).json({error:e})

    }

});

export default taskRouter;  // ← was TaskRouter