define [
  'models/base'
  'syncs/weather'
], (BaseModel, WeatherSync) ->

  class Weather extends BaseModel

    defaults:
      response: {}

    sync: ->
      new WeatherSync arguments

    serverAttrs: [
      'lat'
      'lng'
    ]
