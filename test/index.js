// index.js
const express = require("express");
const path = require("path");

const app = express();
const PORT = 3000;

app.use(express.static("public"));

const data = {
  countries: ["Thailand", "United States", "China"],
  states: {
    Thailand: ["Bangkok", "Chiang Mai", "Phuket"],
    "United States": ["California", "New York", "Texas"],
    China: ["Beijing", "Shanghai", "Guangzhou"],
  },
  cities: {
    Bangkok: ["Bang Khen", "Bang Na", "Lat Phrao"],
    "Chiang Mai": ["Mueang Chiang Mai", "San Sai", "Hang Dong"],
    Phuket: ["Mueang Phuket", "Patong", "Kathu"],
    California: ["Los Angeles", "San Francisco", "San Diego"],
    "New York": ["New York City", "Buffalo", "Rochester"],
    Texas: ["Houston", "Dallas", "Austin"],
    Beijing: ["Haidian", "Chaoyang", "Fengtai"],
    Shanghai: ["Pudong", "Minhang", "Xuhui"],
    Guangzhou: ["Tianhe", "Yuexiu", "Liwan"],
  },
};

app.get("/countries", (req, res) => {
  res.json(data.countries);
});

app.get("/states/:country", (req, res) => {
  const country = req.params.country;
  console.log(typeof data.states[country]);
  res.json(data.states[country] || []);
});

app.get("/cities/:state", (req, res) => {
  const state = req.params.state;
  res.json(data.cities[state] || []);
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
