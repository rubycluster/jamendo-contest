define [
], () ->

  globalSettings =
    app:
      title: 'Play Weather'
      url: 'http://playweather.info'
    cache:
      ajax:
        # time: 0
        time: 30 * 60 * 1000
