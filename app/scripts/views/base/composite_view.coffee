define [
  'views/base/mixins'
  'views/empty'
], (
  ViewsMixins
  EmptyView
) ->

  class BaseCompositeView extends Marionette.View

    emptyView: EmptyView

  _.extend(BaseCompositeView.prototype, ViewsMixins)

  BaseCompositeView
