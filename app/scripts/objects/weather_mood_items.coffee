define [
  'models/weather_mood_item'
], (WeatherMoodItem) ->

  hash =

    temperature:
      title: ''
      color: ''
      icon: 'bar-chart'

    hot:
      title: 'Hot'
      color: 'red'
      icon: 'certificate'
    warm:
      title: 'Warm'
      color: 'orange'
      icon: 'certificate'
    cool:
      title: 'Cool'
      color: 'green'
      icon: 'circle'
    cold:
      title: 'Cold'
      color: 'blue'
      icon: 'asterisk'
    frost:
      title: 'Frost'
      color: 'blue'
      icon: 'asterisk'

    clear:
      title: 'Clear'
      color: 'yellow'
      icon: 'circle-blank'
    cloudy:
      title: 'Cloudy'
      color: 'blue'
      icon: 'cloud'
    overcast:
      title: 'Overcast'
      color: 'asphalt'
      icon: 'cloud-download'

    drizzle:
      title: 'Drizzle'
      color: 'purple'
      icon: 'tint'
    light_rain:
      title: 'Light Rain'
      color: 'purple'
      icon: 'umbrella'
    rain:
      title: 'Rain'
      color: 'purple'
      icon: 'umbrella'
    shower:
      title: 'Shower'
      color: 'purple'
      icon: 'bolt'

    light_snow:
      title: 'Light Snow'
      color: 'blue'
      icon: 'asterisk'
    snow:
      title: 'Snow'
      color: 'blue'
      icon: 'asterisk'
    heavy_snow:
      title: 'Heavy Snow'
      color: 'blue'
      icon: 'asterisk'

    breeze:
      title: 'Breeze'
      color: 'blue'
      icon: 'flag-alt'
    gale:
      title: 'Gale'
      color: 'purple'
      icon: 'flag-checkered'
    storm:
      title: 'Storm'
      color: 'asphalt'
      icon: 'flag'
    hurricane:
      title: 'Hurricane'
      color: 'red'
      icon: 'refresh'

    mist:
      title: 'Mist'
      color: ''
      icon: 'eye-close'
    smoke:
      title: 'Smoke'
      color: ''
      icon: 'eye-close'
    haze:
      title: 'Haze'
      color: ''
      icon: 'eye-close'
    dust:
      title: 'Dust'
      color: ''
      icon: 'eye-close'
    fog:
      title: 'Fog'
      color: ''
      icon: 'eye-close'

  object = {}

  _.each _(hash).keys(), (key) ->
    object[key] = new WeatherMoodItem(hash[key])

  object
