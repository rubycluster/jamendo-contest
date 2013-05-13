define [
  'backbone_marionette'
  'views/empty'
], (Marionette, EmptyView) ->

  class BaseCompositeView extends Marionette.CompositeView

    emptyView: EmptyView
