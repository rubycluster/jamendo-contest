define [
  'views/layouts/base'
  'templates/layouts/main'
  'views/location_form'
  'views/location_title'
  'views/panorama'
  'views/weather_info'
  'views/weather_mood'
  'views/player_track'
  'views/player_controls'
  'views/footer'
  'models/area'
  'models/weather'
  'models/weather_mood'
  'models/track'
], (BaseLayout, template, \
    LocationFormView, LocationTitleView, PanoramaView, WeatherInfoView, \
    WeatherMoodView, PlayerTrackView, PlayerControlsView, FooterView, \
    Area, Weather, WeatherMood, Track) ->

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
      @models.weather_mood = new WeatherMood
      @models.track = new Track

    initViews: ->
      @views.location_form = new LocationFormView
        model: @models.area
      @views.panorama = new PanoramaView
      @views.location_title = new LocationTitleView
        model: @models.area
      @views.weather_info = new WeatherInfoView
        model: @models.weather
      @views.player_track = new PlayerTrackView
        model: @models.track
      @views.player_controls = new PlayerControlsView
        model: @models.track
      @views.weather_mood = new WeatherMoodView
        model: @models.weather_mood
      @views.footer = new FooterView
        hiddenOnce: true

    initViewsEvents: ->
      @views.location_form.on 'location:submit', =>
        @views.player_controls.trigger 'player:stop'
        @hideInfoViews()
        @setBackgroundBlank()
      @models.area.on 'change:position', (model, value) =>
        @views.weather_info.updateWithPosition value
      @models.area.on 'change:position', (model, value) =>
        @views.panorama.updateWithPosition value
      @models.weather.on 'parsed', (model) =>
        @views.weather_mood.updateWithWeather model.get('response')
      @models.weather_mood.on 'change:items', (model, value) =>
        @models.track.updateWithMood(value).fetch()
      @models.area.on 'change:position', (model, value) =>
        @views.footer.showView()

    onRender: ->
      @setBackgroundBlank()
      @assignSubView
        '#location-form': @views.location_form
        '#location-title': @views.location_title
        '#weather-info': @views.weather_info
        '#weather-mood': @views.weather_mood
        '#player-track': @views.player_track
        '#player-controls': @views.player_controls
        '#footer': @views.footer

    hideInfoViews: ->
      _([
        'location_title'
        'weather_mood'
        'weather_info'
        'player_track'
        'player_controls'
        'footer'
      ]).each (name) =>
        @views[name].hideView()

    setBackgroundBlank: ->
      $('body')
        .removeAttr('style')
        .removeClass('cover')
        .addClass('blank')
