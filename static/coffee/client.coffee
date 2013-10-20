
socket = io.connect 'ws://localhost:8000'

socket.on 'disconnect', console.log 
socket.on 'error', console.log 
socket.on 'connect', ->
  console.log 'connected'

  socket.on 'transaction', (t) ->
    $('body').append """
      <p>#{t.vol}</p>@<span>#{t.lat} #{t.lng}</span>
    """