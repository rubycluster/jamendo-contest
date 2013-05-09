define [
  'backbone_marionette'
], (Marionette) ->

  class BaseItemView extends Marionette.ItemView

    initialize: ->

    assignSubView: (selector, view) ->
      if _.isObject(selector)
        selectors = selector
      else
        selectors = {}
        selectors[selector] = view
      return unless selectors
      _.each selectors, (view, selector) ->
        if view && @$(selector)
          view.setElement( @$(selector) ).render()
      , this
