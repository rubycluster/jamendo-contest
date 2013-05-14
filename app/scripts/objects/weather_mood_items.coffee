define [
  'models/weather_mood_item'
], (WeatherMoodItem) ->

  hash =
    temperature:
      title: ''
      color: ''
      icon: 'bar-chart'
    cold:
      title: 'Cold'
      color: 'blue'
      icon: 'asterisk'
    cloudy:
      title: 'Cloudy'
      color: 'asphalt'
      icon: 'cloud'
    rain:
      title: 'Rain'
      color: 'purple'
      icon: 'umbrella'
    hot:
      title: 'Hot'
      color: 'orange'
      icon: 'certificate'
    clear:
      title: 'Clear'
      color: 'yellow'
      icon: 'circle-blank'

  object = {}

  _.each _(hash).keys(), (key) ->
    object[key] = new WeatherMoodItem(hash[key])

  object
