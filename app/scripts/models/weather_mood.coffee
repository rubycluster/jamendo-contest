define [
  'models/base'
  'models/weather_mood_item'
  'helpers/weather_to_visual'
], (BaseModel, WeatherMoodItem, WeatherToVisual) ->

  class WeatherMood extends BaseModel

    defaults:
      title: undefined
      items: []

    collectionItems: ->
      converter = new WeatherToVisual
      converter.collectionItems @get('items')

    generateItems: (weather = {}) ->
      converter = new WeatherToVisual weather
      items = converter.convert().result
      @unset 'items'
        silent: true
      @set 'items', items
