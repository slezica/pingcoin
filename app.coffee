config  = require './config'
express = require 'express'
http    = require 'http'

app = express()

app.set 'views', config.view_root
app.set 'view engine', 'jade'
app.locals config # Make configuration available to templates

app.use express.logger 'dev'
# app.use express.bodyParser()
app.use '/static', express.static config.static_root

app.get '/', (req, res) ->
  res.render 'index', {}


server = http.createServer app
io = require('socket.io').listen server

geoip = require './geoip'
bcoin = require './bitcoin'

bcoin.on 'transaction', (t) ->
  geoip.geolocate t.ip, (err, latlng) ->
    if not err?
      io.sockets.emit 'transaction',
        vol: t.volume
        lat: latlng[0]
        lng: latlng[1] 

bcoin.start()

console.log "Running pingcoin with config", JSON.stringify config, null, 2
server.listen config.node_port