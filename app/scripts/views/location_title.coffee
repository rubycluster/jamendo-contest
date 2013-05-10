define [
  'views/base/item_view'
  'templates/location_title'
  'models/area'
], (BaseItemView, template, Area) ->

  class LocationTitleView extends BaseItemView

    template: template

    el: '#location-title'

    model: Area

    modelEvents:
      'change:position': 'render'
