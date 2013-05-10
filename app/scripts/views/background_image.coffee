define [
  'views/base/item_view'
  'models/area'
  'apis/photo_panorama'
], (BaseItemView, Area, PhotoPanoramaAPI) ->

  class BackgroundImageView extends BaseItemView

    modelEvents:
      'change:position': 'onChangePosition'
      'change:background': 'onChangeBackground'

    onChangePosition: (model, value) ->
      api = new PhotoPanoramaAPI
        data: value
      api.request()
        .done =>
          @model.set 'background', api.result

    onChangeBackground: (model, value) ->
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
