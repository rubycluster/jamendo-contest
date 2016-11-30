define [
  'views/base/mixins'
], (
  ViewsMixins
) ->

  class BaseItemView extends Marionette.View

  _.extend(BaseItemView.prototype, ViewsMixins)

  BaseItemView
