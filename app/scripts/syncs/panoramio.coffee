define [
  'syncs/base'
], (BaseSync) ->

  class PanoramioSync extends BaseSync

    baseUrl: 'http://www.panoramio.com/map/get_panoramas.php'

    dataDefaults:
      set: 'public'
      from: 0
      to: 20
      size: 'medium'
      mapfilter: 'true'
      callback: 'callback'

    prepareData: (rawData) ->
      data = _.clone(rawData)
      @getLocationBounds data
      data

    getLocationBounds: (data) ->
      return unless _.any(data.lat) and _.any(data.lng)
      delta = 0.03
      data.minx = data.lng - delta
      data.miny = data.lat - delta
      data.maxx = data.lng + delta
      data.maxy = data.lat + delta
      delete data.lat
      delete data.lng
      data
