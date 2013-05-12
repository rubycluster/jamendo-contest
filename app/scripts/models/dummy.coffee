define [
  'backbone'
], (Backbone) ->

  class DummyModel extends Backbone.Model

    defaults:
      location:
        address: 'San Francisco, USA'
      player_track:
        title: 'Alive'
        artist: 'P.O.D.'
        album: 'Satellite (2001)'
      weather_mood:
        title: 'Today'
      weather_info:
        response:
          list: _.range(5).reduce( (a, i) ->
            a.push
              dt: 1368360000 + i * 75600
              main:
                temp: _.random(10, 20)
            _(7).times ->
              a.push {}
            a
          , [])
