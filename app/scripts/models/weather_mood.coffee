define [
  'models/base'
  'models/weather_mood_item'
  'objects/weather_mood_items'
  'helpers/weather_to_visual'
], (BaseModel, WeatherMoodItem, weatherMoodItems, WeatherToVisual) ->

  class WeatherMood extends BaseModel

    defaults:
      title: undefined
      items: []

    collectionItems: ->
      _.chain( @get('items') )
        .map( (i) ->
          if _.isObject(i)
            key = _.keys(i)[0]
            value = i[key]
            item = weatherMoodItems[key]
            item.set 'title', value
            item
          else
            weatherMoodItems[i]
        )
        .compact()
        .value()

    generateItems: (weather = {}) ->
      converter = new WeatherToVisual weather
      items = converter.convert().result
      @unset 'items'
        silent: true
      @set 'items', items
