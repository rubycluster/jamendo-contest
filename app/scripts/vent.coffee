define [
  'backbone'
  'backbone_marionette'
], (Backbone, Marionette) ->

  vent = new Backbone.Wreqr.EventAggregator()

  # vent.on "all", ->
  #   console.log arguments

  vent.on 'locale:init', ->
    locale = localStorage?.getItem('locale') || navigator?.language || 'en'
    app.settings.locale = locale
    @trigger 'locale:set', locale

  vent.on 'locale:set', (code, refresh = false) ->
    localStorage?.setItem 'locale', code
    location.reload()  if refresh

  vent
