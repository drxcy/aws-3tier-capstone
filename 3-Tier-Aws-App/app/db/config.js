import pkg from 'pg'
import dotenv from 'dotenv'
dotenv.config()
const { Pool } = pkg
const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
})
pool.connect()
  .then(() => console.log("✅ Connected to Postgres"))
  .then(() => pool.query("SELECT NOW();"))
  .then(res => {
    console.log("DB Time:", res.rows[0]);
  })
  .catch(err => console.error("❌ Connection error", err.message))
  .finally(() => pool.end());
  console.log(process.env.DATABASE_URL)
export default pool