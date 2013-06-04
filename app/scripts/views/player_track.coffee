define [
  'views/base/item_view'
  'templates/player_track'
  'models/track'
], (BaseItemView, template, Track) ->

  class PlayerTrackView extends BaseItemView

    template: template

    el: '#player-track'

    modelEvents:
      'sync': 'render'

    initialize: ->
      super
      @model ||= new Track
      @

    onBeforeRender: ->
      @hideView()

    onRender: ->
      @isValidToShow() && @showView()

    isValidToShow: ->
      _.any @model.get('title')
