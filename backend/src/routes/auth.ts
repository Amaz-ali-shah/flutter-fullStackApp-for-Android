import {Router, type Request, type Response} from "express";
import { error } from "node:console";
import { db } from "../db/index.js";

const authRouter = Router();   // create instance


interface SignUpBody{
    name:string;
    email:string;
    password:string;
}

authRouter.post("/signup/:id",async (req :Request<{},{},SignUpBody>,res :Response)=>{
    try{
        //create a new user and store it in Db

        req.body();
        db.select().from(users).where(eq(users.email,email));

    } catch(e){
        res.status(500).json({error:e})

    } 



})

authRouter.get("/", (req,res) => {
    res.send("Hey there from auth");
});

export default authRouter;     // ✅ export the instance