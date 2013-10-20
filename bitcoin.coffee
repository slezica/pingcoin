io = require 'socket.io-client'
{EventEmitter} = require 'events'

module.exports = new EventEmitter


socket = io.connect 'ws://ws.blockchain.info/inv'
socket.on 'connect', ->
  console.log 'connected'
  socket.on 'message', console.log
  socket.send '{"op":"unconfirmed_sub"}'
