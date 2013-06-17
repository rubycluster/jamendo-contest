define [
  'models/base'
  'models/weather_mood_item'
  'helpers/weather_to_visual'
], (BaseModel, WeatherMoodItem, WeatherToVisual) ->

  class WeatherMood extends BaseModel

    defaults:
      title: undefined
      items: []
      weather: {}

    initialize: ->
      super
      @on 'change:weather', @generateItems
      @

    collectionItems: ->
      converter = new WeatherToVisual
      converter.collectionItems @get('items')

    generateItems: (model, weather = {}) ->
      converter = new WeatherToVisual weather
      items = converter.convert().result
      @touch 'items', items
