import {type Request,type Response, type NextFunction} from  "express";
import {type  UUID } from "crypto";
import jwt from "jsonwebtoken";
import { eq } from "drizzle-orm";

import type authRouter from "../routes/auth.js";
import { db } from "../db/index.js";
import { users } from "../db/schema.js";

export interface AuthRequest extends Request {
    user?:UUID;
    token?: string;

}


export const auth = async(
    req: AuthRequest,
    res:Response,
    next:NextFunction)=>
        {
            try{
            
                    const token =req.header("X-Authorization");
                    if(!token){
                        res.status(401).json({msg:"No Auth token, access denied"});
                        return;
                    }
                    const verified=jwt.verify(token,"passwordKey");
            
                    if (!verified){
                        res.status(401).json({msg:"Token Verification Failed!"});
                        
                        return;
            
                    }
                    const verifiedToken = verified as {id:UUID};
            
            
                    const [user] = await db.select().from(users).where(eq(users.id,verifiedToken.id));
                    if(!user){
                        res.status(401).json({msg:"User Not Found "});
                        
                        return;
                    }
                    req.user=verifiedToken.id;
                    req.token=token;
                    next();

                }
                catch (e) {
                    res.status(500).json(false);
                }

    };


