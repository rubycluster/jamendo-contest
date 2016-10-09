'use strict'

define [
  'backbone'
  'backbone_marionette'
  'templates'
  'config/global_handlers'
  'config/settings'
  'vent'
  'app_controller'
  'app_router'
  'app_deps'
], (
  Backbone
  Marionette
  Templates
  GlobalHandlers
  settings
  vent
  AppController
  AppRouter
) ->

  Marionette.Renderer.render = (template, data) ->
    if typeof template is 'string' and typeof Templates[template] is 'function'
      Templates[template](data)
    else if typeof template is 'function'
      template(data)
    else
      console.log '[marionette] template is not found:', template

  app = new Marionette.Application()

  app.settings = settings

  app.vent = vent

  app.templates = Templates

  app.layout = undefined

  app.on 'initialize:before', (options) ->

  app.on 'initialize:after', (options) ->
    setTimeout ->
      Backbone.history.start
        pushState: false
        root: '/'
    , 1000

  app.addInitializer ->
    GlobalHandlers.init(app)

  app.addInitializer ->
    app.vent.trigger('settings:init')

  app.addInitializer ->
    app.vent.trigger('cache:ajax:drop', 'expired')

  app.addInitializer ->
    $(document)
      .on('ajaxStart', ->
        $('.ajax-spinner').addClass('spin')
      )
      .on('ajaxStop', ->
        $('.ajax-spinner').removeClass('spin')
      )

  app.addInitializer ->
    app.appController = new AppController()
    app.appRouter = new AppRouter
      controller: app.appController

  app
