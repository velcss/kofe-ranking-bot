const express = require("express");
const axios = require("axios");

const app = express();
app.use(express.json());

const ROBLOX_COOKIE = process.env.ROBLOX_COOKIE;
const GROUP_ID = process.env.GROUP_ID;

app.post("/rank", async (req, res) => {
  const { userId, roleId } = req.body;

  if (!userId || !roleId) {
    return res.status(400).json({ error: "Missing userId or roleId" });
  }

  try {
    await axios.patch(
      `https://groups.roblox.com/v1/groups/${GROUP_ID}/users/${userId}`,
      { roleId },
      {
        headers: {
          Cookie: `.ROBLOSECURITY=${ROBLOX_COOKIE}`,
          "Content-Type": "application/json"
        }
      }
    );

    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: "Ranking failed" });
  }
});

app.get("/", (req, res) => {
  res.send("✅ Roblox Ranking Bot Online");
});

app.listen(3000, () => console.log("Bot running on port 3000"));
