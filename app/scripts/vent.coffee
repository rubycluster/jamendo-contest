define [
  'backbone'
  'backbone_marionette'
  'syncs/base'
], (
  Backbone
  Marionette
  BaseSync
) ->

  vent = new Backbone.Wreqr.EventAggregator()

  vent.data = {}

  # vent.on "all", ->
  #   console.log arguments

  vent.on 'settings:init', ->
    vent.trigger('locale:init')
    vent.trigger('temp_units:init')

  vent.on 'locale:init', ->
    locale = localStorage?.getItem('locale') || navigator?.language || 'en'
    app.settings.locale = locale
    @trigger('locale:set', locale)

  vent.on 'locale:set', (code, refresh = false) ->
    localStorage?.setItem('locale', code)
    app.settings.locale = code
    location.reload()  if refresh

  vent.on 'temp_units:init', ->
    temp_units = localStorage?.getItem('temp_units') || 'c'
    app.settings.temp_units = temp_units
    @trigger('temp_units:set', temp_units)

  vent.on 'temp_units:set', (value, refresh = false) ->
    localStorage?.setItem('temp_units', value)
    app.settings.temp_units = value
    location.reload()  if refresh

  vent.on 'cache:ajax:drop', (scope) ->
    BaseSync.prototype.dropCache(scope)

  vent
