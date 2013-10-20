$ ->
  opts =
    zoom: 2
    center: new google.maps.LatLng(0, 0)
    mapTypeId: google.maps.MapTypeId.ROADMAP

    panControl: false
    zoomControl: false
    mapTypeControl: false
    scaleControl: false
    streetViewControl: false
    overviewMapControl: false
    draggable: false
    scrollwheel: false

  map = new google.maps.Map document.getElementById("map-canvas"), opts

  socket = io.connect 'ws://localhost:8000'

  socket.on 'disconnect', console.log 
  socket.on 'error', console.log 
  socket.on 'connect', ->
    console.log 'connected'

    socket.on 'transaction', (t) ->
      marker = new google.maps.Marker
        position: new google.maps.LatLng t.lat, t.lng
        map: map
        title: 'Hello World!'

  # $('body').append """
  #   <p>#{t.vol}</p>@<span>#{t.lat} #{t.lng}</span>
  # """