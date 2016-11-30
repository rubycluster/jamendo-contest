define [
  'store_original'
], (
  store
) ->

  _.extend store,
    setOriginal: store.set
    getOriginal: store.get

  _.extend store,

    set: (key, val, exp = undefined) ->
      if exp? and exp > 0
        @setOriginal key,
          time: new Date().getTime()
          exp: exp
          val: val
      else
        @setOriginal key, val

    get: (key) ->
      info = @getOriginal key
      if _.isObject(info) and info.exp? and info.time?
        if not @isExpired key
          info.val
        else
          @remove(key)
          null
      else
        info

    isExpired: (key) ->
      info = @getOriginal(key)
      return null  unless info?
      info.exp? and info.time? and \
        (info.exp < new Date().getTime() - info.time)

  store
