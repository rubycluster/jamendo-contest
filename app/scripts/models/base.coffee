define [
  'backbone'
], (Backbone) ->

  class BaseModel extends Backbone.Model

    serverAttrs: []

    get: (attr) ->
      if typeof this[attr] is "function"
        this[attr]()
      else
        super

    toServerJSON: ->
      json = _.clone @toJSON()
      if _.any @serverAttrs
        json = _.pick json, @serverAttrs

    parse: (response, options) ->
      parsed =
        response: response
