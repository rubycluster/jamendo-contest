define [
  'models/base'
  'syncs/weather'
], (BaseModel, WeatherSync) ->

  class Weather extends BaseModel

    defaults:
      response: {}

    syncer: WeatherSync

    serverAttrs: [
      'lat'
      'lng'
    ]
