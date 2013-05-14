define [
  'backbone_marionette'
  'views/base/mixins'
], (Marionette, ViewsMixins) ->

  class BaseItemView extends Marionette.ItemView

  _.extend BaseItemView.prototype, ViewsMixins

  BaseItemView
