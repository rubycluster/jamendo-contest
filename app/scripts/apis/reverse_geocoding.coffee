define [
  'apis/base'
], (BaseAPI) ->

  class ReverseGeocodingAPI extends BaseAPI

    baseUrl: 'http://maps.googleapis.com/maps/api/geocode/json'

    dataDefaults:
      sensor: 'false'
      language: 'en'
      # lat: undefined
      # lng: undefined

    prepareData: ->
      @prepareDataLatLng()
      super

    prepareResult: ->
      data = super?.results
      data = data && _(data).first()?.address_components
      data = data? && _(data).find (i) ->
        _(i.types).include('locality')
      data = data?.long_name
      @result = data || ''

    prepareDataLatLng: ->
      if @options.data?.lat? and @options.data?.lng?
        latlng = [
          @options.data.lat
          @options.data.lng
        ].join(',')
        delete @options.data.lat
        delete @options.data.lng
        @options.data.latlng = latlng
