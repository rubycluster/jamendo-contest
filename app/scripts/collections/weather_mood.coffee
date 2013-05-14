define [
  'collections/base'
  'models/weather_mood_item'
], (BaseCollection, WeatherMoodItem) ->

  class WeatherMood extends BaseCollection

    model: WeatherMoodItem
