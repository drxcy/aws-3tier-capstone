import dotenv from 'dotenv'
dotenv.config()
import pkg from 'pg'
const { Pool } = pkg
const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
})
pool.connect()
  .then(client => {
    console.log("✅ Connected to Postgres")
    return client.query("SELECT NOW();")
      .then(res => {
        console.log("DB Time:", res.rows[0])
      })
      .finally(() => client.release()) 
  })
  .catch(err => console.error("❌ Connection error", err.message,err.stack))
//   console.log(process.env.DATABASE_URL)
//   console.log("DATABASE_URL:", process.env.DATABASE_URL)
console.log("Current directory:", process.cwd());
console.log("DATABASE_URL exists:", !!process.env.DATABASE_URL);
console.log("DATABASE_URL value:", process.env.DATABASE_URL);

  
export default pool;