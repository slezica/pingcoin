ws = require 'ws'
{EventEmitter} = require 'events'

module.exports = evt = new EventEmitter

socket = ws.connect 'ws://ws.blockchain.info/inv'

evt.start = ->
  socket.on 'open', ->
    evt.emit 'connected'

    socket.on 'message', (event) ->
      data = JSON.parse event
      ip = data.x.relayed_by
      volume = 0
      data.x.out.map (e) ->
        volume += e.value

      evt.emit 'transaction', {'ip': ip, 'volume': volume}

    socket.send '{"op":"unconfirmed_sub"}'

    socket.on 'disconnect', ->
      evt.emit 'disconnect'

    socket.on 'error', ->
      evt.emit 'error', arguments


