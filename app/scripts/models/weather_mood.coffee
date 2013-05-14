define [
  'models/base'
  'models/weather_mood_item'
  'objects/weather_mood_items'
], (BaseModel, WeatherMoodItem, weatherMoodItems) ->

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

    generateItems: (weather) ->
      items = [
        {temperature: '10&deg;C'}
        'cold'
        'cloudy'
        'rain'
      ]
      @unset 'items'
        silent: true
      @set 'items', items
