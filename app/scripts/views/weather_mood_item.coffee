define [
  'views/base/item_view'
  'templates/weather_mood_item'
  'models/weather'
], (
  BaseItemView
  template
  WeatherMoodItem
) ->

  class WeatherMoodItemView extends BaseItemView

    template: template

    attributes:
      class: 'one fifth mobile'

    onBeforeRender: ->
      $(@el).on 'click', (e) ->
        e.stopPropagation()
        false
      $(@el).hide()

    onRender: ->
      $(@el).fadeIn('slow')
