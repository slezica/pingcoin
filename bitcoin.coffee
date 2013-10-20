ws = require 'ws'

socket = ws.connect 'ws://ws.blockchain.info/inv'
socket.on 'open', ->
  console.info 'Starting connection'
  socket.on 'message', (event) ->
    data = JSON.parse event
    ip = data.x.relayed_by
    volume = 0
    data.x.out.map (e) ->
      volume += e.value
    console.log {'ip': ip, 'volume': volume}
    # TODO: Geolocate and push data to clients
  socket.send '{"op":"unconfirmed_sub"}'
