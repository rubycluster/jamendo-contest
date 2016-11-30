define [
  'views/base/mixins'
], (
  ViewsMixins
) ->

  class BaseLayout extends Marionette.View

  _.extend(BaseLayout.prototype, ViewsMixins)

  BaseLayout
