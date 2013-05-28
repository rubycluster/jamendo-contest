define [
  'syncs/base'
  'config/settings'
], (BaseSync, settings) ->

  class JamendoTracksSync extends BaseSync

    baseUrl: 'http://api.jamendo.com/v3.0/tracks/'

    paramsDefaults: $.extend(true, {}, @paramsDefaults, {
      dataType: 'json'
    })

    dataDefaults:
      client_id: settings.keys.jamendo.client_id
      format: 'json'
      limit: 10
      include: 'musicinfo'
      # lang: 'en'
      # order: undefined
      # speed: undefined
      # namesearch: undefined
      # tags: undefined
      # fuzzytags: undefined
      # search: undefined
