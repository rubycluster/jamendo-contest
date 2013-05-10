define [
  'views/layouts/base'
  'templates/layouts/main'
  'views/location_form'
  'views/location_title'
  'views/background_image'
  'models/area'
], (BaseLayout, template, LocationFormView, LocationTitleView, BackgroundImageView, Area) ->

  class MainLayout extends BaseLayout

    template: template

    el: '.container'

    regions:
      wrapper: '#main-wrapper'
      container: '#main-container'
      location_form: '#location_form'
      location_title: '#location-title'
      player_track: '#player-track'
      player_controls: '#player-controls'
      weather_mood: '#weather-mood'
      weather_info: '#weather-info'
      footer: '#footer'

    models: {}
    views: {}

    initialize: ->
      @initModels()
      @initViews()
      @render()
      @

    initModels: ->
      @models.area = new Area()

    initViews: ->
      @views.location_form = new LocationFormView
        model: @models.area
      @views.location_title = new BackgroundImageView
        model: @models.area
      @views.location_title = new LocationTitleView
        model: @models.area

    onRender: ->
      $('body')
        .removeClass('cover')
        .addClass('blank')
      @assignSubView
        '#location-form': @views.location_form
        '#location-title': @views.location_title
