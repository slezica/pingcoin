config  = require './config'
express = require 'express'

app = express()

app.set 'views', config.view_root
app.set 'view engine', 'jade'
app.locals config # Make configuration available to templates

app.use express.logger 'dev'
# app.use express.bodyParser()
app.use '/static', express.static config.static_root


app.get '/', (req, res) ->
  res.render 'index', {}


console.log "Running pingcoin with config", JSON.stringify config, null, 2
app.listen config.node_port