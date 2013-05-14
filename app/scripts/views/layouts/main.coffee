define [
  'views/layouts/base'
  'templates/layouts/main'
  'views/location_form'
  'views/location_title'
  'views/panorama'
  'views/weather_info'
  'views/weather_mood'
  'views/footer'
  'models/area'
  'models/weather'
], (BaseLayout, template, LocationFormView, LocationTitleView, PanoramaView, WeatherInfoView, WeatherMoodView, FooterView, Area, Weather) ->

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
      @initViewsEvents()
      @render()
      @

    initModels: ->
      @models.area = new Area
      @models.weather = new Weather

    initViews: ->
      @views.location_form = new LocationFormView
        model: @models.area
      @views.panorama = new PanoramaView
      @views.location_title = new LocationTitleView
        model: @models.area
      @views.weather_info = new WeatherInfoView
        model: @models.weather
      @views.weather_mood = new WeatherMoodView
      @views.footer = new FooterView
        hiddenOnce: true

    initViewsEvents: ->
      @views.location_form.on 'location:submit', =>
        @hideInfoViews()
      @models.area.on 'change:position', (model, value) =>
        @views.weather_info.updateWithPosition value
      @models.area.on 'change:position', (model, value) =>
        @views.panorama.updateWithPosition value
      @models.weather.on 'change:response', (model, value) =>
        @views.weather_mood.updateWithWeather value
      @models.area.on 'change:position', (model, value) =>
        @views.footer.showView()

    onRender: ->
      $('body')
        .removeClass('cover')
        .addClass('blank')
      @assignSubView
        '#location-form': @views.location_form
        '#location-title': @views.location_title
        '#weather-info': @views.weather_info
        '#weather-mood': @views.weather_mood
        '#footer': @views.footer

    hideInfoViews: ->
      _([
        'location_title'
        'weather_mood'
        'weather_info'
        'footer'
      ]).each (name) =>
        @views[name].hideView()
