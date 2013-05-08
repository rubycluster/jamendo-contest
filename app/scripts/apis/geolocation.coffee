define [
  'apis/base'
], (BaseAPI) ->

  class GeolocationAPI extends BaseAPI

    geolocate: ->
      dfr = $.Deferred()
      if navigator.geolocation
        navigator.geolocation.getCurrentPosition (result) ->
          position =
            lat: result.coords.latitude
            lng: result.coords.longitude
          dfr.resolve position
        , ->
          dfr.reject "Geolocation service failed."
      else
        dfr.reject "Browser doesn't support geolocation."
      dfr
