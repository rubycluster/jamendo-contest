define [
  'backbone_marionette'
  'templates/home'
  'models/dummy'
], (
  Marionette
  template
  DummyModel
) ->

  class HomePageView extends Marionette.ItemView

    template: template

    el: '.container'

    initialize: ->
      @model = new DummyModel()
      @render()
      @

    onRender: ->
      url = "http://static.panoramio.com/photos/original/64910164.jpg"
      $('body')
        .attr('style', null)
        .removeClass('cover')
        .addClass('blank')
        .removeClass('blank')
        .addClass('cover')
        .attr('style', 'background-image: url(' + url + ')')
