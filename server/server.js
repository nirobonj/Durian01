// const express = require("express");
// const bodyParser = require("body-parser");
// const { Pool } = require("pg");
// // const multer = require("multer");
// // const path = require("path");
// const app = express();
// const port = 3000;

// // เชื่อมต่อกับฐานข้อมูล PostgreSQL
// const pool = new Pool({
//   user: "postgres",
//   host: "localhost",
//   database: "duriansound",
//   password: "123456789",
//   port: 5432,
// });

// app.post("/register", async (req, res) => {
//     try {
//       console.log("Received data:", req.body);
//       const { firstname, lastname, tel, province, type, username, password } = req.body;
//         console.log(req.body);
//       // เชื่อมต่อกับฐานข้อมูลและทำการบันทึกข้อมูลลงในตาราง users
//       const client = await pool.connect();
//       const result = await client.query(
//         `INSERT INTO users firstname, lastname, tel, province, type, username, password) 
//          VALUES ($1, $2, $3, $4, $5, $6, $7)`,
//         [firstname, lastname, tel, province, type, username, password]
//       );
//       client.release();
  
//       // ส่งข้อความกลับว่าการบันทึกข้อมูลสำเร็จ
//       res.status(201).send("User registered successfully");
//     } catch (error) {
//       console.error("Error while registering user:", error);
//       res.status(500).send("Error registering user");
//     }
//   });
  
// // เริ่มต้นเซิร์ฟเวอร์
// app.listen(port, () => {
//     console.log(`Server is running on http://localhost:${port}`);
//   });

const express = require("express");
const bodyParser = require("body-parser");
const { Pool } = require("pg");

const app = express();
const port = 3000;

// เพิ่ม middleware เพื่อให้ Express รับข้อมูลแบบ JSON
app.use(bodyParser.json());

// เพิ่ม middleware เพื่อให้ Express รับข้อมูลแบบ URL-encoded form
app.use(bodyParser.urlencoded({ extended: true }));

// เชื่อมต่อกับฐานข้อมูล PostgreSQL
const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "duriansound",
  password: "123456789",
  port: 5432,
});

app.post("/register", async (req, res) => {
  try {
    console.log("Received data:", req.body);
    const { firstname, lastname, tel, province, type, username, password } = req.body;
    // เชื่อมต่อกับฐานข้อมูลและทำการบันทึกข้อมูลลงในตาราง users
    const client = await pool.connect();
    const result = await client.query(
      `INSERT INTO users (firstname, lastname, tel, province, type, username, password) 
       VALUES ($1, $2, $3, $4, $5, $6, $7)`,
      [firstname, lastname, tel, province, type, username, password]
    );
    client.release();

    // ส่งข้อความกลับว่าการบันทึกข้อมูลสำเร็จ
    res.status(201).send("User registered successfully");
  } catch (error) {
    console.error("Error while registering user:", error);
    res.status(500).send("Error registering user");
  }
});

// เริ่มต้นเซิร์ฟเวอร์
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
