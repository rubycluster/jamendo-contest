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
  'views/bookmarks'
  'views/help'
  'views/vote'
  'models/area'
  'models/weather'
  'models/weather_mood'
  'models/track'
  'vent'
], (BaseLayout, template, \
    LocationFormView, LocationTitleView, PanoramaView, WeatherInfoView, \
    WeatherMoodView, PlayerTrackView, PlayerControlsView, \
    FooterView, BookmarksView, HelpView, VoteView, \
    Area, Weather, WeatherMood, Track, \
    vent) ->

  class MainLayout extends BaseLayout

    template: template

    el: '.container'

    regions:
      wrapper: '#main-wrapper'
      container: '#main-container'
      help: '#help'
      location_form: '#location_form'
      bookmarks: '#bookmarks'
      location_title: '#location-title'
      player_track: '#player-track'
      player_controls: '#player-controls'
      weather_mood: '#weather-mood'
      weather_info: '#weather-info'
      footer: '#footer'
      vote: '#vote'

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
      @views.help = new HelpView
      @views.location_form = new LocationFormView
        model: @models.area
      @views.panorama = new PanoramaView
      @views.bookmarks = new BookmarksView
        model: @models.area
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
      @views.vote = new VoteView

    initViewsEvents: ->
      @views.location_form.on 'location:submit', =>
        @views.player_controls.trigger 'player:stop'
        @hideInfoViews()
        @setBackgroundBlank()
      @views.location_form.on 'location:change:position', (model, value) =>
        @views.footer.showView()
      @views.location_form.on 'location:change:position', (model, value) =>
        @views.weather_info.updateWithPosition value
      @views.location_form.on 'location:change:position', (model, value) =>
        @views.panorama.updateWithPosition value
      @views.weather_info.on 'weather:change', (model) =>
        @views.weather_mood.updateWithWeather model.get('response')
      @views.weather_mood.on 'weather_mood:change:items', (model, value) =>
        @views.player_controls.updateWithMood value
      @views.player_controls.on 'player:init', =>
        fn = _.bind @views.vote.showViewIfValid, @views.vote
        _.delay fn, 3000
      vent.on 'temp_units:set', =>
        $('body').scrollTop 0
        @views.weather_info.render()
        @views.weather_mood.model.touch 'weather'
        @views.weather_mood.render()

    onRender: ->
      @setBackgroundBlank()
      @assignSubView
        '#help': @views.help
        '#location-form': @views.location_form
        '#bookmarks': @views.bookmarks
        '#location-title': @views.location_title
        '#weather-info': @views.weather_info
        '#weather-mood': @views.weather_mood
        '#player-track': @views.player_track
        '#player-controls': @views.player_controls
        '#footer': @views.footer
        '#vote': @views.vote

    hideInfoViews: ->
      _([
        'help'
        'location_title'
        'bookmarks'
        'weather_mood'
        'weather_info'
        'player_track'
        'player_controls'
        'footer'
        'vote'
      ]).each (name) =>
        @views[name].hideView()

    setBackgroundBlank: ->
      $('body')
        .removeAttr('style')
        .removeClass('cover')
        .addClass('blank')
