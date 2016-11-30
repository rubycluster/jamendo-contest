define [
  'app'
  'deps/app_deps'
  'styles/all'
], (
  app
) ->

  $ ->
    window.app = app
    app.start()
