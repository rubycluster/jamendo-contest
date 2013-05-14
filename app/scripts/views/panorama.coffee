define [
  'views/base/item_view'
  'models/panorama'
], (BaseItemView, Panorama) ->

  class PanoramaView extends BaseItemView

    modelEvents:
      'change:url': 'changeBackground'

    initialize: ->
      super
      @model ||= new Panorama
      @

    updateWithPosition: (value) ->
      @model.set
        lat: value.lat
        lng: value.lng
      @model.fetch()

    changeBackground: (model, value) ->
      if _.any(value)
        @setBackgroundImage value
      else
        @setBackgroundBlank()

    setBackgroundImage: (url) ->
      $('body')
        .removeClass('blank')
        .addClass('cover')
        .attr('style', 'background-image: url(' + url + ')')

    setBackgroundBlank: ->
      $('body')
        .attr('style', null)
        .removeClass('cover')
        .addClass('blank')

    render: ->
