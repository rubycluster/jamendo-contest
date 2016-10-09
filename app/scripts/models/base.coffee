define [
  'backbone'
], (
  Backbone
) ->

  class BaseModel extends Backbone.Model

    serverAttrs: []

    get: (attr) ->
      if typeof this[attr] is "function"
        this[attr]()
      else
        super

    toServerJSON: ->
      json = _.clone(@toJSON())
      if _.any(@serverAttrs)
        mapAttrs = _(@serverAttrs).select (attr) ->
          /{}$/.test(attr)
        pickAttrs = _.difference(@serverAttrs, mapAttrs)

        if _.any(pickAttrs)
          json = _.pick(json, pickAttrs)
        else
          json = {}

        if _.any(mapAttrs)
          hash = _.chain(mapAttrs)
            .map (attr) ->
              attr.split(/{}$/)[0]
            .reduce( (memo, attr) =>
              delete json[attr]
              _.extend(memo, @get(attr))
            , {})
            .value()
          _.extend json, hash

        json

    parse: (response, options) ->
      parsed =
        response: response

    sync: ->
      if _.isFunction(@syncer)
        sync = new @syncer
        sync.process(arguments)
      else
        super

    fetch: (options = {}) ->
      if _.isFunction(@syncer)
        options = _.clone(options)
        method = options.method || 'read'
        if _.isUndefined(options.parse)
          options.parse = true
        @sync(method, @, options)
      else
        super

    touch: (attr, value = undefined) ->
      return unless attr?
      value ||= @get(attr)
      @unset attr,
        silent: true
      @set(attr, value)
