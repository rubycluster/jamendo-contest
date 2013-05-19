define [
  'models/base'
  'syncs/jamendo_tracks'
  'helpers/mood_to_tracks_request'
], (BaseModel, JamendoTracksSync, MoodToTracksRequest) ->

  class Track extends BaseModel

    defaults:
      response: {}
      attrs: {}
      media_urls:
        mp31: undefined
        mp32: undefined
        ogg: undefined
        flac: undefined
      title: undefined
      artist: undefined
      album: undefined
      cover_image_url: undefined

    syncer: JamendoTracksSync

    serverAttrs: [
      'attrs{}'
    ]

    parse: (response, options) ->
      parsed = super
      result = _(response.results).chain().shuffle().first().value()
      if _.any result
        @parseAttributesFromResult parsed, result
      parsed

    parseAttributesFromResult: (parsed, result) ->
      _.extend parsed,
        title: result.name
        artist: result.artist_name
        album: result.album_name
        cover_image_url: result.album_image
        media_urls:
          mp31: result.audio

    updateWithMood: (items) ->
      converter = new MoodToTracksRequest items
      attrs = converter.convert().result
      @set
        attrs: attrs
      @
