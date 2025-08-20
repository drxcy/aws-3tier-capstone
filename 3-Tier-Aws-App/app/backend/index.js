import express from "express";
import dotenv from "dotenv";
import cors from "cors";
const PORT = 5000;



const app = express();
app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.send("Backend API is running 🚀");
});


app.get("/api/message", (req, res) => {
  res.json({ message: "Hello from Node.js backend!" });
});

app.listen(PORT, () => {
  console.log(`✅ Server running on port ${PORT}`);
});
