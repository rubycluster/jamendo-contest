define [
  'models/weather_mood_item'
], (
  WeatherMoodItem
) ->

  hash =

    temperature:
      color: ''
      icon: 'bar-chart'

    hot:
      color: 'red'
      icon: 'certificate'
    warm:
      color: 'orange'
      icon: 'certificate'
    cool:
      color: 'green'
      icon: 'circle'
    cold:
      color: 'blue'
      icon: 'asterisk'
    frost:
      color: 'blue'
      icon: 'asterisk'

    clear:
      color: 'yellow'
      icon: 'circle-blank'
    cloudy:
      color: 'blue'
      icon: 'cloud'
    overcast:
      color: 'asphalt'
      icon: 'cloud-download'

    drizzle:
      color: 'purple'
      icon: 'tint'
    light_rain:
      color: 'purple'
      icon: 'umbrella'
    rain:
      color: 'purple'
      icon: 'umbrella'
    shower:
      color: 'purple'
      icon: 'bolt'

    light_snow:
      color: 'blue'
      icon: 'asterisk'
    snow:
      color: 'blue'
      icon: 'asterisk'
    heavy_snow:
      color: 'blue'
      icon: 'asterisk'

    breeze:
      color: 'blue'
      icon: 'flag-alt'
    gale:
      color: 'purple'
      icon: 'flag-checkered'
    storm:
      color: 'asphalt'
      icon: 'flag'
    hurricane:
      color: 'red'
      icon: 'refresh'

    mist:
      color: ''
      icon: 'eye-close'
    smoke:
      color: ''
      icon: 'eye-close'
    haze:
      color: ''
      icon: 'eye-close'
    dust:
      color: ''
      icon: 'eye-close'
    fog:
      color: ''
      icon: 'eye-close'

  _(hash).chain()
    .reduce( (memo, value, key) ->
      memo[key] = value
      memo[key]['title'] ||=
        locale.t("weather_mood.#{key}") || ''
      memo
    , {})
    .reduce( (memo, value, key) ->
      memo[key] = new WeatherMoodItem(value)
      memo
    , {})
    .value()
