
import { Router } from "express";
import { auth } from "../middleware/auth.js";  // ← remove "type", auth is a value not a type
import type { AuthRequest } from "../middleware/auth.js";
import { tasks, type NewTask } from "../db/schema.js";
import { db } from "../db/index.js";
import { eq } from "drizzle-orm";

const taskRouter = Router();  // ← was TaskRouter

taskRouter.post("/", auth, async (req: AuthRequest, res) => {

    try{
        req.body={...req.body, dueAt:new Date(req.body.dueAt),uid:req.user};
        const newTask : NewTask = req.body;
       const task =  await db.insert(tasks).values(newTask).returning();
        res.status(201).json(task);
    } catch (e){
        console.log(e);
        res.status(500).json({error:e})

    }

});



taskRouter.get("/", auth, async (req: AuthRequest, res) => {

    try{
       
       const allTasks =  await db.select().from(tasks).where(eq(tasks.uid,req.user!));

        res.json(allTasks);
    } catch (e){
        console.log(e);
        res.status(500).json({error:e})

    }

});



taskRouter.delete("/", auth, async (req: AuthRequest, res) => {

    try{
        const {taskId}:{taskId:string} =req.body;
       
       await db.delete(tasks).where(eq(tasks.id,taskId));

        res.json(true);
    } catch (e){
        console.log(e);
        res.status(500).json({error:e})

    }

});



export default taskRouter;  // ← was TaskRouter