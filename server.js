const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {

  console.log({
    headers: req.headers,
    body: req.body,
    message: "working now"
  });

  res.send('Hello from Node.js App on Docker Swarm!');
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});
