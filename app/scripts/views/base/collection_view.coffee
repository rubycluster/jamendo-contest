define [
  'views/base/mixins'
  'views/empty'
], (
  ViewsMixins
  EmptyView
) ->

  class BaseCollectionView extends Marionette.CollectionView

    emptyView: EmptyView

  _.extend(BaseCollectionView.prototype, ViewsMixins)

  BaseCollectionView
