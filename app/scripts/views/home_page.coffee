define [
  'backbone_marionette'
  'templates/home'
  'models/dummy'
], (Marionette, template, DummyModel) ->

  class HomePageView extends Marionette.ItemView

    template: template

    el: '.container'

    initialize: ->
      @model = new DummyModel()
      @render()
      @

    onRender: ->
      $('body')
        .removeClass('cover')
        .addClass('blank')
        .removeClass('blank')
        .addClass('cover')
