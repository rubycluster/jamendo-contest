define [
  'views/layouts/main'
  'views/home_page'
], (
  MainLayout
  HomePageView
) ->

  root: ->
    console.log '[navigate] root'
    # new HomePageView()
    app.layout = new MainLayout

  missing: ->
    console.log '[navigate] missing'
