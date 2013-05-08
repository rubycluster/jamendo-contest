define [
  'apis/base'
], (BaseAPI) ->

  class WheatherAPI extends BaseAPI

    baseUrl: 'http://api.openweathermap.org/data/2.5/weather'

    dataDefaults:
      lang: 'en'
      units: 'metric'
      mode: 'json'
      # lat: undefined
      # lon: undefined
      # q: undefined

    initialize: (options) ->
      super
      @request()
      @

    ajaxParams: ->
      $.extend {}, super,
        dataType: 'jsonp'
