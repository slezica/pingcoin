
getRadius = (time, radius) ->
  # 5 seconds growing, 5 decreasing
  # TODO: Make this a parabole
  val = 0
  if time > 5000
    val = (time - 5000) / 500
  else if time > 10000
    val = 0
  else
    val = time / 500
  val * radius
  

LAPSE = 50

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
      updates = 1
      circle = new google.maps.Circle
        strokeColor: '#FF0000'
        strokeOpacity: 0.8
        strokeWeight: 2
        fillColor: '#FF0000'
        fillOpacity: 0.35
        map: map
        center: new google.maps.LatLng t.lat, t.lng
        radius: getRadius 1, t.vol
      update = ->
        updates += 1
        elapsed = LAPSE * updates
        radius = getRadius elapsed, t.vol
        circle.set 'radius', radius
        if radius > 0
          setTimeout update, LAPSE
      setTimeout update, LAPSE

