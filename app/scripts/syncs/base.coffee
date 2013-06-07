define [
  'backbone'
  'store'
  'config/settings'
  'md5'
], (Backbone, store, settings, md5) ->

  class BaseSync

    cacheTime: settings.global.cache.ajax.default.time
    cachePrefix: 'cache-ajax-'

    paramsDefaults:
      type: 'GET'
      dataType: 'jsonp'

    baseUrl: undefined
    dataDefaults: {}

    process: ->
      @sync.apply @, arguments[0]

    sync: (method, model, options = {}) ->
      set_options = _(options).omit 'params', 'attrs'
      params = $.extend true, {}, @paramsDefaults, options.params || {}
      params.url = @baseUrl
      data = $.extend true, {}, @dataDefaults, (options.attrs || model.toServerJSON(options))
      params.data = @prepareData data
      model.trigger 'request', model, xhr, options
      xhr = options.xhr = @cachedAjax params
      xhr.done (response, status, xhr) =>
        model.set model.parse(response), set_options
        if options.success
          options.success @, response, set_options
        model.trigger 'sync', model, response, set_options
      xhr

    prepareData: (data = {}) ->
      compactFn = (memo, value, key) ->
        if not _.isEmpty(value) || _.isNumber(value)
          memo[key] = value
        memo

      _.chain(data)
        .clone()
        .reduce(compactFn, {})
        .value()

    cachedAjax: (params) ->
      if @cacheTime > 0
        info = store.get @cacheKey(params)
        info? && @deferredCache(info) || @deferredAjax(params)
      else
        @deferredAjax(params)

    deferredCache: (info) ->
      dfd = $.Deferred()
      setTimeout ->
        dfd.resolve info.response, info.status, dfd
      , 500
      dfd

    deferredAjax: (params) ->
      dfd = Backbone.ajax params
      dfd.done (response, status, xhr) =>
        store.set @cacheKey(params),
          response: response
          status: status
        , @cacheTime
      dfd

    cacheKey: (params) ->
      hash = md5 JSON.stringify(params)
      @cachePrefix + hash

    dropCache: (scope = 'expired') ->
      re = new RegExp('^'+ @cachePrefix + '\\w*$')
      _.reduce(store.getAll(), (memo, value, key) ->
        if re.test(key)
          if scope is 'expired' and store.isExpired(key) or scope is 'all'
            memo.push key
            store.remove key
        memo
      , [])
