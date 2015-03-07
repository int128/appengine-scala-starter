express = require 'express'
app = express()

app.use express.static process.env.webapp

app.get '/like', (req, res) ->
  res.set 'Content-Type', 'application/json'
  res.send JSON.stringify
    count: 100

app.post '/like', (req, res) ->
  res.set 'Content-Type', 'application/json'
  res.send JSON.stringify
    count: 200

app.listen process.env.port
