define [
  'syncs/base'
  'config/settings'
], (BaseSync, settings) ->

  class JamendoTracksSync extends BaseSync

    baseUrl: 'http://api.jamendo.com/v3.0/tracks/'

    cacheTime: settings.global.cache.ajax.jamendo_tracks.time

    paramsDefaults: $.extend(true, {}, @paramsDefaults, {
      dataType: 'json'
    })

    dataDefaults:
      client_id: settings.keys.jamendo.client_id
      format: 'json'
      limit: 50
      include: 'musicinfo'
      audioformat: 'mp31'
      # lang: 'en'
      # speed: undefined
      # namesearch: undefined
      # tags: undefined
      # fuzzytags: undefined
      # search: undefined
