define [
  'views/base/item_view'
  'templates/footer'
], (BaseItemView, template) ->

  class FooterView extends BaseItemView

    template: template

    el: '#footer'
