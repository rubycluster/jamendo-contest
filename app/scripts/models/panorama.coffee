define [
  'models/base'
  'syncs/panoramio'
], (BaseModel, PanoramioSync) ->

  class Panorama extends BaseModel

    defaults:
      response: {}
      url: undefined

    syncer: PanoramioSync

    serverAttrs: [
      'lat'
      'lng'
    ]

    parse: (response, options) ->
      parsed = super
      parsed.url = @parseUrl response
      parsed

    parseUrl: (response) ->
      photos = response.photos
      random = _.random(0, _(photos).size() - 1)
      photos[random].photo_file_url || ''
