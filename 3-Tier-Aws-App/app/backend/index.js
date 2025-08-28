import dotenv from "dotenv";
dotenv.config({path: '../db/.env'});
import pool  from "../db/config.js";
import express from "express";
import cors from "cors";
const PORT = 5000;
const app = express();
app.use(cors());
app.use(express.json());
// DATABASE_URL= process.env.DATABASE_URL;

app.get("/", (req, res) => {
  res.send("Backend API is running 🚀");
});


app.get("/api/message", (req, res) => {
  res.json({ message: "Hello from Node.js backend!" });
});
// Get all users
app.get("/api/users", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM users");
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).send("DB error");
  }
});
// console.log("Current directory:", process.cwd());
// console.log("DATABASE_URL exists:", !!process.env.DATABASE_URL);
// console.log("DATABASE_URL value:", process.env.DATABASE_URL);

console.log("DATABASE:", process.env.DATABASE_URL);
app.listen(PORT, () => {
  console.log(`✅ Server running on port ${PORT}`);
});
