define [
  'syncs/base'
], (BaseSync) ->

  class GeocodingSync extends BaseSync

    baseUrl: 'http://maps.googleapis.com/maps/api/geocode/json'

    dataDefaults:
      sensor: 'false'
      language: 'en'
      # address: undefined

    paramsDefaults:
      type: 'GET'
      dataType: 'json'

    prepareData: (data) ->
      data = super
      @prepareLatLng data
      data

    prepareLatLng: (data) ->
      if data?.position?.lat? and data?.position?.lng?
        formatCoord = (number) ->
          tail = 8
          rounder = Math.pow 10, tail
          Math.round(number * rounder) / rounder
        latlng = [
          formatCoord data.position.lat
          formatCoord data.position.lng
        ].join(',')
        delete data.position
        data.latlng = latlng
