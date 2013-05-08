define [
  'apis/base'
], (BaseAPI) ->

  class GeocodingAPI extends BaseAPI

    baseUrl: 'http://maps.googleapis.com/maps/api/geocode/json'

    dataDefaults:
      sensor: 'false'
      language: 'en'
      # address: undefined

    initialize: (options) ->
      super
      @request()
      @

    prepareResult: ->
      data = super?.results
      data = data? && _(data).first()?.geometry?.location
      @result = data || {}
