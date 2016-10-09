define [
  'backbone_marionette'
  'views/base/mixins'
  'views/empty'
], (
  Marionette
  ViewsMixins
  EmptyView
) ->

  class BaseCompositeView extends Marionette.CompositeView

    emptyView: EmptyView

  _.extend(BaseCompositeView.prototype, ViewsMixins)

  BaseCompositeView
