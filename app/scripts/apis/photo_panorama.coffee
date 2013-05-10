define [
  'apis/base'
], (BaseAPI) ->

  class PhotoPanoramaAPI extends BaseAPI

    baseUrl: 'http://www.panoramio.com/map/get_panoramas.php'

    dataDefaults:
      set: 'public'
      from: 0
      to: 20
      size: 'medium'
      mapfilter: 'true'
      callback: 'callback'
      # lat: undefined
      # lon: undefined
      # minx: undefined
      # miny: undefined
      # maxx: undefined
      # maxy: undefined

    ajaxParams: ->
      $.extend {}, super,
        dataType: 'jsonp'

    prepareData: ->
      delta = 0.03
      @options.data.minx = @options.data.lng - delta
      @options.data.miny = @options.data.lat - delta
      @options.data.maxx = @options.data.lng + delta
      @options.data.maxy = @options.data.lat + delta
      delete @options.data.lat
      delete @options.data.lng
      super

    prepareResult: ->
      data = super?.photos
      random = data? && _.random(0, _(data).size() - 1)
      data = _(data).any? && data[random]
      data = data? && data.photo_file_url
      @result = data || ''
