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
    draggable: true
    scrollwheel: true

  map = new google.maps.Map document.getElementById('canvas'), opts

  ping = ({lat, lng, vol}) ->
    base_radius = Math.log(Math.max(vol, 50000)) / Math.log(1.07) * 2000
    console.log base_radius
    min_radius = base_radius / 4
    max_radius = base_radius * 4

    circle = new google.maps.Circle
      strokeColor: '#FFFFFF'
      strokeOpacity: 0.5
      strokeWeight: 1
      fillColor: '#000000'
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
