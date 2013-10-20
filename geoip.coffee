geoip = require('geoip-lite');

@geolocate = (ip, done) ->
  result = geoip.lookup ip
  if result?
    done null, result.ll
  else
    done 'not found'