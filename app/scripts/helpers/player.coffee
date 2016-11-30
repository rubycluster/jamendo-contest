define [
  'mediaelement/build/mediaelement-and-player.js'
], (
) ->

  class Player

    defaultSettings:
      audioWidth: '100%'
      features: [
        'current'
        'progress'
        'duration'
        'volume'
      ]
      mode: 'auto'
      plugins: [
        'flash'
        'silverlight'
      ]
      pluginPath: '/images/meplayer/'

    constructor: ->
      @initialize.apply(@, arguments)

    initialize: (el, settings = {}) ->
      @el = el
      @settings = settings
      _.defaults(@settings, @defaultSettings)
      @api = new MediaElementPlayer(@el, @settings)
      @
