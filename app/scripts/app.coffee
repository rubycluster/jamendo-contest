define [
  'templates'
  'deps/global_handlers'
  './config/settings'
  'vent'
  'app_controller'
  'app_router'
], (
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

  app.listenTo app, 'start', ->
    GlobalHandlers.init(app)
    app.vent.trigger('settings:init')
    app.vent.trigger('cache:ajax:drop', 'expired')
    $(document)
      .on('ajaxStart', ->
        $('.ajax-spinner').addClass('spin')
      )
      .on('ajaxStop', ->
        $('.ajax-spinner').removeClass('spin')
      )
    app.appController = AppController
    app.appRouter = new AppRouter
      controller: app.appController
    setTimeout ->
      Backbone.history.start
        pushState: false
        root: '/'
    , 1000

  app
