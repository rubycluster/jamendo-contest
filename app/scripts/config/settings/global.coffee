define [
], () ->

  globalSettings =
    app:
      title: 'Play Weather'
      url: 'http://playweather.info'
    cache:
      ajax:
        default:
          time: 1000 * 60 * 30
        geocoding:
          time: 1000 * 60 * 60 * 6
        jamendo_tracks:
          time: 1000 * 60 * 60 * 3
        panoramio:
          time: 1000 * 60 * 60 * 6
        weather:
          time: 1000 * 60 * 30
