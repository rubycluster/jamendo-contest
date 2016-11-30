define [
  'i18n-js'
  './en'
  './ru'
], (
  i18n
  localeEn
  localeRu
) ->

  i18n.translations.en = localeEn
  i18n.translations.ru = localeRu
  i18n.locale =
    localStorage?.getItem('locale') || 'en'
  i18n.fallbacks = true
  i18n
