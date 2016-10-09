define [
  'views/base/item_view'
  'templates/help'
  'vent'
], (
  BaseItemView
  template
  vent
) ->

  class HelpView extends BaseItemView

    template: template

    el: '#help'

    initialize: ->
      super
      vent.on 'help:toggle', =>
        @isHidden() && @showView() || @hideView()

    onBeforeRender: ->
      @hideView()

    hideView: ->
      $(@el).slideUp('fast')

    onRender: ->
      @isValidToShow() && @showView()

    isValidToShow: ->
      false
