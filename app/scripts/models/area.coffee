define [
  'backbone'
], (Backbone) ->

  class Area extends Backbone.Model

    defaults:
      title: undefined
      position:
        lat: undefined
        lng: undefined
      background: undefined
