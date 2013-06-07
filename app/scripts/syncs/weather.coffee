define [
  'syncs/base'
  'config/settings'
], (BaseSync, settings) ->

  class WeatherSync extends BaseSync

    baseUrl: 'http://api.openweathermap.org/data/2.5/forecast'

    cacheTime: settings.global.cache.ajax.weather.time

    dataDefaults:
      lang: 'en'
      units: 'metric'
      mode: 'json'

    prepareData: (rawData) ->
      data = _.clone(rawData)
      @renameParams data
      data

    renameParams: (data) ->
      return unless _.isFinite(data.lng)
      data.lon = data.lng
      delete data.lng
      data
