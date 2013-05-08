define [
  'backbone'
], (Backbone) ->

  class DummyModel extends Backbone.Model

    defaults:
      location:
        title: 'San Francisco, USA'
      player_track:
        title: 'Alive'
        artist: 'P.O.D.'
        album: 'Satellite (2001)'
      weather_mood:
        title: 'Today'
