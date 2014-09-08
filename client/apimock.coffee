express = require 'express'
app = express()

app.use express.static process.env.webapp

app.listen process.env.port
