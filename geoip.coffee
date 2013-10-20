geoip = require('geoip-lite');

@geolocate = (ip, done) ->
  done null, geoip.lookup(ip).ll