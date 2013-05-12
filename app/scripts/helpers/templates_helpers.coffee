define [
  'vendor/haml_helpers'
], (HAMLHtmlHelpers) ->

  TemplatesHelpers = {}

  _.extend TemplatesHelpers, HAMLHtmlHelpers

  # Add HAML helpers here available from templates
  _.extend TemplatesHelpers,

    filterWeatherDays: (list) ->
      _.chain(list)
        .filter( (item, index) ->
          (index + 8) % 8 == 0
        )
        .first(5)
        .value()

  TemplatesHelpers
