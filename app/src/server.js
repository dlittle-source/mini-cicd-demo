const express = require('express');
const app = express();

const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send(`
    <h1>🚀 Mini CI/CD Demo App</h1>
    <p>Deployed via multi-stage CI/CD pipeline</p>
    <p>Environment: ${process.env.NODE_ENV || 'development'}</p>
  `);
});

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'OK' });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
