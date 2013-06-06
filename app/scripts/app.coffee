'use strict'

define [
  'backbone'
  'backbone_marionette'
  'templates'
  'config/settings'
  'vent'
  'app_controller'
  'app_router'
  'app_deps'
], (Backbone, Marionette, Templates, settings, vent, AppController, AppRouter) ->

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

  app.on "initialize:before", (options) =>

  app.on "initialize:after", (options) =>
    Backbone.history.start
      pushState: false
      root: '/'

  app.addInitializer ->
    app.vent.trigger 'locale:init'

  app.addInitializer ->
    app.vent.trigger 'cache:ajax:drop', 'expired'

  app.addInitializer ->
    $(document)
      .on('ajaxStart', ->
        $('.ajax-spinner').addClass 'spin'
      )
      .on('ajaxStop', ->
        $('.ajax-spinner').removeClass 'spin'
      )

  app.addInitializer ->
    app.appController = new AppController()
    app.appRouter = new AppRouter
      controller: app.appController

  app
