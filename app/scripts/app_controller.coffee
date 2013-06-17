define [
  'backbone_marionette'
  'views/layouts/main'
  'views/home_page'
], (Marionette, MainLayout, HomePageView) ->

  class AppController extends Marionette.Controller

    root: ->
      console.log '[navigate] root'
      # new HomePageView()
      app.layout = new MainLayout

    missing: ->
      console.log '[navigate] missing'
