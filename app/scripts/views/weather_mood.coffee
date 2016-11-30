define [
  'views/base/composite_view'
  'views/weather_mood_items'
  'templates/weather_mood'
  'collections/weather_mood'
  'models/weather_mood'
], (
  BaseCompositeView
  WeatherMoodItemsView
  template
  WeatherMoodCollection
  WeatherMood
) ->

  class WeatherMoodView extends BaseCompositeView

    template: template

    el: '#weather-mood'

    regions:
      body:
        el: '.tiles'
        replaceElement: true

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
      @collection.set(model.get('collectionItems'))
      @showView()
      @trigger('weather_mood:change:items', model, value)

    updateWithWeather: (weatherResponse) ->
      day = weatherResponse.list[0]
      human_date = moment(day.dt * 1000).format('LL')
      title = [
        locale.t('weather_info.today')
        human_date
      ].join(', ')
      @collection.reset()
      @model.set('title', title)
      @model.set('weather', day)

    onBeforeRender: ->
      @hideView()

    onRender: ->
      @isValidToShow() && @showView()
      @showChildView 'body', new WeatherMoodItemsView
        collection: @collection

    isValidToShow: ->
      _.any(@model.get('title')) and _.any(@model.get('items'))
