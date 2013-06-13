define [
  'views/base/composite_view'
  'views/weather_mood_item'
  'templates/weather_mood'
  'collections/weather_mood'
  'models/weather_mood'
  'moment'
  'i18n!nls/locale'
], (BaseCompositeView, WeatherMoodItemView, template, WeatherMoodCollection, WeatherMood, moment, locale) ->

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
      day = weatherResponse.list[0]
      human_date = moment(day.dt * 1000).format('LL')
      title = [
        locale.weather_info.today
        human_date
      ].join(', ')
      @collection.reset()
      @model.set 'title', title
      @model.generateItems day

    onBeforeRender: ->
      @hideView()

    onRender: ->
      @isValidToShow() && @showView()

    isValidToShow: ->
      _.any @model.get('title') and _.any @model.get('items')
