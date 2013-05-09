define [
  'backbone_marionette'
  'templates/layouts/main'
], (Marionette, template) ->

  class MainLayout extends Marionette.Layout

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
