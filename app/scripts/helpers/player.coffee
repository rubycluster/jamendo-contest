define [
  'mediaelement'
], () ->

  class Player

    defaultSettings:
      audioWidth: '100%'
      features: [
        'current'
        'progress'
        'duration'
        'volume'
      ]

    constructor: ->
      @initialize.apply @, arguments

    initialize: (el, settings = {}) ->
      @el = el
      @settings = settings
      _.defaults @settings, @defaultSettings
      @api = new MediaElementPlayer @el, @settings
      @
