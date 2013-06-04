define [
  'views/base/item_view'
  'templates/weather_info'
  'models/weather'
], (BaseItemView, template, Weather) ->

  class WeatherView extends BaseItemView

    template: template

    el: '#weather-info'

    modelEvents:
      'change:response': 'render'

    initialize: ->
      window.info = @
      super
      @model ||= new Weather
      @

    updateWithPosition: (value) ->
      @model.set
        lat: value.lat
        lng: value.lng
      @model.fetch()

    onBeforeRender: ->
      $(@el).on 'click', '.tile', (e) ->
        e.stopPropagation()
        false
      @hideView()

    onRender: ->
      @isValidToShow() && @showView()

    isValidToShow: ->
      _.any @model.get('response')
