// import { Client } from 'pg'

// const client = new Client({
//   user: "postgres",
//   host: "localhost",  // or "db" if inside Docker compose
//   database: "appdb",
//   password: "postgres",
//   port: 5432,
// });

// client.connect()
//   .then(() => console.log("✅ Connected to Postgres"))
//   .then(() => client.query("SELECT NOW();"))
//   .then(res => {
//     console.log("DB Time:", res.rows[0]);
//   })
//   .catch(err => console.error("❌ Connection error", err))
//   .finally(() => client.end());
