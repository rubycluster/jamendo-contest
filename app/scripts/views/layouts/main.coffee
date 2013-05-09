define [
  'views/layouts/base'
  'templates/layouts/main'
  'views/location_form'
], (BaseLayout, template, LocationFormView) ->

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

    initialize: ->
      @render()
      @

    onRender: ->
      @assignSubView
        '#location-form': new LocationFormView
