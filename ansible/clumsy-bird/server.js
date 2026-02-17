const express = require('express');
const app = express();

const PORT = 3000;

app.get('/', (req, res) => {
  res.send(`
    <h1>🐤 Clumsy Bird is Running!</h1>
    <p>AMI Built Successfully with Packer + Ansible 🚀</p>
  `);
});

app.listen(PORT, () => {
  console.log(`Clumsy Bird running on port ${PORT}`);
});
