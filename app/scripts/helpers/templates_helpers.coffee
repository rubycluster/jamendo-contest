define [
  'vendor/haml_helpers'
], (
  HAMLHtmlHelpers
) ->

  TemplatesHelpers = {}

  _.extend(TemplatesHelpers, HAMLHtmlHelpers)

  # Add HAML helpers here available from templates
  _.extend TemplatesHelpers,

    filterWeatherDays: (list, dayTime) ->
      delta = {day: 0, night: 4}[dayTime]
      _.chain(list)
        .filter( (item, index) ->
          (index + delta + 8) % 8 == 0
        )
        .first(5)
        .value()

    mediaMimeTypes: () ->
      types =
        mp31: 'audio/mpeg'
        mp32: 'audio/mpeg'
        ogg:  'audio/ogg'
        flac: 'audio/ogg'

    temperatureWithUnits: (value) ->
      units = app.settings.temp_units
      options =
        c:
          units: 'C'
          formula: (value) -> value
        f:
          units: 'F'
          formula: (value) -> value * 9/5 + 32
      [
        Math.round options[units].formula(value)
        '&deg;'
        options[units].units
      ].join ''

  TemplatesHelpers
