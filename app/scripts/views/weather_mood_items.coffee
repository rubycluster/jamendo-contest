define [
  'views/base/collection_view'
  'views/weather_mood_item'
], (
  BaseCollectionView
  WeatherMoodItemView
) ->

  class WeatherMoodItemsView extends BaseCollectionView

    childView: WeatherMoodItemView

    className: 'tiles row'
