define [
  'views/base/item_view'
  'templates/footer'
  'vent'
], (BaseItemView, template, vent) ->

  class FooterView extends BaseItemView

    template: template

    el: '#footer'

    events:
      'change #locales': 'changeLocales'

    changeLocales: (e) ->
      localeCode = $(e.currentTarget).val()
      vent.trigger 'locale:set', localeCode, true
