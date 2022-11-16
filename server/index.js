const express = require('express');
const bodyParser = require('body-parser');

const router = require('./routes/routes');

const port = 8080 || process.env.PORT;

const app = express();

app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());

app.use("/", router);

app.listen(port, () => {
    console.log('Server running at http://localhost:8080');
})





