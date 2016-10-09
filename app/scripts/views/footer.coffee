define [
  'views/base/item_view'
  'templates/footer'
  'vent'
], (
  BaseItemView
  template
  vent
) ->

  class FooterView extends BaseItemView

    template: template

    el: '#footer'

    events:
      'change #locales': 'changeLocales'
      'change #temp_units': 'changeTempUnits'

    changeLocales: (e) ->
      localeCode = $(e.currentTarget).val()
      vent.trigger('locale:set', localeCode, true)

    changeTempUnits: (e) ->
      unit = $(e.currentTarget).val()
      vent.trigger('temp_units:set', unit)
