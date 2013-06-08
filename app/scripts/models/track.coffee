define [
  'models/base'
  'syncs/jamendo_tracks'
  'helpers/mood_to_tracks_request'
], (BaseModel, JamendoTracksSync, MoodToTracksRequest) ->

  class Track extends BaseModel

    serverRoot: 'http://jamendo.com'

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
          ogg: result.audio.replace /mp31/, 'ogg1'
        track_url: [ @serverRoot, 'track', result.id ].join('/')
        artist_url: [ @serverRoot, 'artist', result.artist_id ].join('/')
        album_url: [ @serverRoot, 'album', result.album_id ].join('/')

    updateWithMood: (items) ->
      converter = new MoodToTracksRequest items
      attrs = converter.convert().result
      @set
        attrs: attrs
      @
