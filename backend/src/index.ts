import express from "express";
import authRouter from "./routes/auth.js";

const app = express();
app.use(express.json())

app.use("/auth",authRouter)


app.get("/", (req,res) =>{
    res.send("Welcome to my app by  amazzz ali shah !");
})
 
app.listen(8000,()=>{

    console.log("Server started on port 8000");
})