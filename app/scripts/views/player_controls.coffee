define [
  'views/base/item_view'
  'templates/player_controls'
  'models/track'
  'helpers/player'
], (BaseItemView, template, Track, Player) ->

  class PlayerControlsView extends BaseItemView

    template: template

    el: '#player-controls'

    ui:
      audio: '#player'

    modelEvents:
      'sync': 'render'

    triggers:
      'click .button-play': 'player:play'
      'click .button-stop': 'player:stop'
      'click .button-pause': 'player:pause'
      'click .button-backward': 'player:backward'
      'click .button-forward': 'player:forward'

    initialize: ->
      super
      @model ||= new Track
      @initTriggers()
      @

    initTriggers: ->
      @on 'player:play', =>
        @player? && @player.api.play()
      @on 'player:stop', =>
        @player? && @player.api.pause()
      @on 'player:pause', =>
        @player? && @player.api.pause()

    initPlayer: ->
      @player = new Player @ui.audio

    onBeforeRender: ->
      @hideView()

    onRender: ->
      if @isValidToShow()
        @showView()
        @initPlayer()
        @fixPressButtonF()
        @player.api.play()

    isValidToShow: ->
      _.any @model.get('media_urls')

    fixPressButtonF: ->
      @player.api.enterFullScreen = undefined
      setTimeout ->
        $('body').trigger('click')
      , 1000

    onBeforeHide: ->
      $('audio').attr 'src', ''
