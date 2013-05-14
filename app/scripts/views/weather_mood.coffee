define [
  'views/base/composite_view'
  'views/weather_mood_item'
  'templates/weather_mood'
  'collections/weather_mood'
  'models/weather_mood'
], (BaseCompositeView, WeatherMoodItemView, template, WeatherMoodCollection, WeatherMood) ->

  class WeatherMoodView extends BaseCompositeView

    template: template

    el: '#weather-mood'

    itemViewContainer: '.tiles'

    itemView: WeatherMoodItemView

    modelEvents:
      'change:items': 'onItemsChange'
      'change:title': 'render'

    initialize: ->
      super
      @model ||= new WeatherMood
      @collection ||= new WeatherMoodCollection
      @

    onItemsChange: (model, value) ->
      @hideView()
      @collection.set model.get('collectionItems')
      @showView()

    updateWithWeather: (weatherResponse) ->
      @collection.reset()
      @model.set 'title', 'Today'
      @model.generateItems weatherResponse.list[0]

    onBeforeRender: ->
      @hideView()

    onRender: ->
      @isValidToShow() && @showView()

    isValidToShow: ->
      _.any @model.get('title') and _.any @model.get('items')
