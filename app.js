
var express = require('express');
var app = express();
app.use(express.static(__dirname));

app.listen(process.env.PORT || 4000);

console.log(`Listening on ${process.env.PORT || 4000}`)
