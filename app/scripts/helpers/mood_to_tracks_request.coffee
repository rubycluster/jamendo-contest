define [
  'underscore'
], (
  _
) ->

  class MoodToTracksRequest

    mapRequest:

      default:
        a:
          vocalinstrumental: 'instrumental'
          fuzzytags: 'easylistening'
          speed: 'low'

      cloudy:
        a:
          vocalinstrumental: 'instrumental'
          fuzzytags: 'ambient'
          speed: 'medium'

      overcast:
        a:
          fuzzytags: 'gothicmetal+gothicrock+gothic+goth'
          speed: 'low'
        b:
          vocalinstrumental: 'instrumental'
          fuzzytags: 'ambient'
          speed: 'low'

      snow:
        a:
          vocalinstrumental: 'instrumental'
          fuzzytags: 'piano'
          speed: 'low'
        b:
          fuzzytags: 'acousticguitar+minor'
          speed: 'low'

      snow_wind:
        a:
          vocalinstrumental: 'instrumental'
          fuzzytags: 'piano'
          speed: 'veryhigh'

      rain:
        a:
          fuzzytags: 'blues+minor'

      rain_wind:
        a:
          fuzzytags: 'bluesrock+minor'
          speed: 'high'

      frost:
        a:
          vocalinstrumental: 'instrumental'
          fuzzytags: 'epic+orchestral'

      cold:
        a:
          fuzzytags: 'cold'

      hot:
        a:
          vocalinstrumental: 'vocal'
          fuzzytags: 'ska+major'
          speed: 'high'

      storm:
        a:
          fuzzytags: 'drumnbass'
          speed: 'medium'
        b:
          fuzzytags: 'metal+rock'
          speed: 'medium'

      hurricane:
        a:
          fuzzytags: 'metal+rock'
          speed: 'high'

      blind:
        a:
          fuzzytags: 'synthesizer+ambient'

    mapVisualOrder: [
      'pre'
      'snow'
      'rain'
      'wind'
      'clouds'
      'temperature_feeling'
      'atmosphere'
    ]

    mapVisual:
      pre: [
        {
          key: 'wind'
          condition:
            type: 'or'
            keys: [
              'gale'
              'storm'
            ]
        }
      ]

      snow: [
        {
          key: 'snow'
          condition:
            type: 'or'
            keys: [
              'snow'
              'heavy_snow'
            ]
        }
        {
          key: 'snow_wind'
          condition:
            type: 'and'
            keys: [
              ':snow'
              ':wind'
            ]
        }
      ]

      rain: [
        {
          key: 'rain'
          condition:
            type: 'or'
            keys: [
              'drizzle'
              'light_rain'
              'rain'
              'shower'
            ]
        }
        {
          key: 'rain_wind'
          condition:
            type: 'and'
            keys: [
              ':rain'
              ':wind'
            ]
        }
      ]

      wind: [
        {
          key: 'hurricane'
        }
      ]

      clouds: [
        {
          key: 'overcast'
        }
        {
          key: 'cloudy'
        }
      ]

      temperature_feeling: [
        {
          key: 'hot'
        }
        {
          key: 'cold'
        }
        {
          key: 'frost'
        }
      ]

      atmosphere: [
        {
          key: 'blind'
          condition:
            type: 'or'
            keys: [
              'mist'
              'smoke'
              'haze'
              'overcast'
              'dust'
              'fog'
            ]
        }
      ]

    constructor: ->
      @initialize.apply(@, arguments)

    initialize: (items = {}) ->
      @items = _.clone(items)
      @result = {}
      @

    convert: ->
      # @setDummyAll()
      @setFromMap()
      @

    # setDummyAll: ->
    #   @setResult 'hot'

    setFromMap: ->

      keyMatches = (key, items) =>
        if /^:/.test key
          orig_key = key.match(/^:(.*)$/)[1]
          _.include(@found, orig_key)
        else
          _.include(items, key)

      ruleApplies = (rule, items) =>
        result = false
        if rule.condition?.type == 'and'
          result = _.all rule.condition.keys, (key) ->
            keyMatches(key, items)
          symbolic = _.all rule.condition.keys, (key) ->
            /^:/.test(key)
          if result and symbolic
            _.each rule.condition.keys, (key) =>
              orig_key = key.match(/^:(.*)$/)[1]
              @found = _(@found).without(orig_key)
        else if rule.condition?.type == 'or'
          result = _.any rule.condition.keys, (key) ->
            keyMatches(key, items)
        else
          result = _.include(items, rule.key)
        result

      ruleApply = (rule, items) =>
        if ruleApplies rule, items
          @found.push(rule.key)

      @found = []

      _.each @mapVisualOrder, (category) =>
        _.each @mapVisual[category], (rule) =>
          ruleApply(rule, @items, @found)

      key = _.first(@found)

      @setResult key

    setResult: (key = 'default', sub_key = undefined) ->
      map = _.clone(@mapRequest)
      key = 'default'  unless map[key]?
      sub_key ||= _.chain(map[key]).keys().shuffle().first().value()
      result = map[key][sub_key]
      @result = result
