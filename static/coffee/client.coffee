
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

  ping = ({lat, lng, vol}) ->
    base_radius = 1000000
    min_radius = base_radius / 4
    max_radius = base_radius * 4

    circle = new google.maps.Circle
      strokeColor: '#FF0000'
      strokeOpacity: 0.8
      strokeWeight: 2
      fillColor: '#FF0000'
      fillOpacity: 0.35
      map: map
      center: new google.maps.LatLng lat, lng
      radius: base_radius

    shrink = (t) ->
      circle.set 'radius', circle.radius * 0.9
      if circle.radius > min_radius
        setTimeout shrink, 10

    grow = ->
      circle.set 'radius', circle.radius * 1.1
      if circle.radius < 2 * base_radius
        setTimeout grow, 10
      else
        shrink()

    grow()

  socket = io.connect 'ws://localhost:8000'

  socket.on 'disconnect', console.log 
  socket.on 'error', console.log 
  socket.on 'connect', ->
    console.log 'connected'

    socket.on 'transaction', (t) ->
      ping t
