define [
  'underscore'
  'objects/weather_mood_items'
], (_, weatherMoodItems) ->

  class WeatherToVisual

    options:
      temperature:
        units: 'C'

    map:

      temperature_feeling:
        hot:   [ 25, 99]
        warm:  [ 17, 25]
        cool:  [ 6,  17]
        cold:  [-9 ,  6]
        frost: [-99, -9]

      clouds:
        clear: [800]
        cloudy: [801, 802, 803]
        overcast: [804]

      rain:
        drizzle: [300, 301, 302, 310, 311, 312, 321]
        light_rain: [500, 501]
        rain: [502, 503, 504]
        shower: [511, 520, 521, 522]

      snow:
        light_snow: [600]
        snow: [601]
        heavy_snow: [602]

      wind:
        breeze:    [ 1.6, 10.7]
        gale:      [10.7, 24.4]
        storm:     [24.4, 32.6]
        hurricane: [32.6, 99.0]

      atmosphere:
        mist: [701]
        smoke: [711]
        haze: [721]
        dust: [731]
        fog: [741]

    constructor: ->
      @initialize.apply @, arguments

    initialize: (weather = {}) ->
      @weather = weather
      @result = []
      @

    convert: ->
      # @setDummyAll()
      @setTemperature()
      @setTemperatureFeeling()
      @setClouds()
      @setRain()
      @setSnow()
      @setWind()
      @setAtmosphere()
      @

    setDummyAll: ->
      @result = [
        {temperature: '10&deg;C'}
      ]
      _.chain(@map)
        .keys()
        .map( (key) =>
          _(@map[key]).keys()
        )
        .flatten()
        .each (name) =>
          @result.push name
        .value()

    setTemperature: ->
      temperature = Math.round @weather.main.temp
      formatted = [
        temperature
        '&deg;'
        @options.temperature.units
      ].join ''
      @result.push
        'temperature': formatted

    setTemperatureFeeling: ->
      @setFromMapByRange 'temperature_feeling', @weather.main.temp

    setClouds: ->
      @setFromMap 'clouds'

    setRain: ->
      @setFromMap 'rain'

    setSnow: ->
      @setFromMap 'snow'

    setWind: ->
      @setFromMapByRange 'wind', @weather.wind.speed

    setAtmosphere: ->
      @setFromMap 'atmosphere'

    setFromMap: (mapKey) ->
      results = []
      codes = _(@weather.weather).map (code) -> code.id
      map = @map[mapKey]
      _(map).reduce( (memo, mapCodes, name) ->
        condition = _.any mapCodes, (mapCode) ->
          _(codes).include mapCode
        if condition
          memo.push name
        memo
      , results)
      _.chain(results)
        .compact()
        .uniq()
        .each( (i) => @result.push(i) )
        .value()

    setFromMapByRange: (mapKey, value) ->
      result = undefined
      map = @map[mapKey]
      _(map).each (range, key) ->
        if value >= range[0] and value < range[1]
          result = key
      if _.any(result)
        @result.push result

    collectionItems: (value) ->
      value ||= @convert().result
      _.chain(value)
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
