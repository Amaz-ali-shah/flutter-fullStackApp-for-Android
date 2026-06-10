import { Router, type Request, type Response } from "express";
import { db } from "../db/index.js";
import { users, type NewUser } from "../db/schema.js";
import { eq } from "drizzle-orm";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken"

const authRouter = Router();

interface SignUpBody {
    name: string;
    email: string;
    password: string;
}

interface LoginBody{
    email: string;
    password: string;

}

authRouter.post("/signup", async (req: Request<{}, {}, SignUpBody>, res: Response) => {
    try {
        const { name, email, password } = req.body;  // ✅ destructure

        const existingUser = await db.select().from(users).where(eq(users.email, email));

        if (existingUser.length) {
            res.status(400).json({ msg: "User with the same Email already exists" });
            return;
        }

        const hashedPassword = await bcrypt.hash(password, 8);

        const newUser: NewUser = {   // ✅ correct type
            name,
            email,
            password: hashedPassword,
        };

        const [user] = await db.insert(users).values(newUser).returning();
        res.status(201).json(user);

    } catch (e) {
        res.status(500).json({ error: e });
    }
});




authRouter.post("/login", async (req: Request<{}, {}, LoginBody>, res: Response) => {
    try {
        const {  email, password } = req.body;  // ✅ destructure

        const [existingUser] = await db.select().from(users).where(eq(users.email, email));

        if (!existingUser) {
            res.status(400).json({ msg: "User with the Email does not exist!" });
            return;
        }

        const isMatch = await bcrypt.compare(password, existingUser.password);

        if(!isMatch){
                res.status(400).json({msg: "Incorrect Password"});
                return;
        }
        const token = jwt.sign({id:existingUser.id},"passwordKey");
        
        const { password: _, ...userWithoutPassword } = existingUser;

        res.json({ token, ...userWithoutPassword });  // ✅ no password hash exposed

    } catch (e) {
        res.status(500).json({ error: e });
    }
});


authRouter.get("/", (req, res) => {
    res.send("Hey there from auth");
});

export default authRouter;