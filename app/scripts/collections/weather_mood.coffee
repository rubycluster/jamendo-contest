define [
  'collections/base'
  'models/weather_mood_item'
], (
  BaseCollection
  WeatherMoodItem
) ->

  class WeatherMoodCollection extends BaseCollection

    model: WeatherMoodItem
