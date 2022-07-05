const express = require('express');
const app = express();

app.get("/",(req,res)=>{
    res.status(200).send('Hello World from EKS')
})

app.listen(3000,console.log("Server Listening on Port http://0.0.0.0:3000"))