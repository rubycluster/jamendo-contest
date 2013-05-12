define [
  'backbone'
], (Backbone) ->

  class BaseModel extends Backbone.Model

    serverAttrs: []

    toServerJSON: ->
      json = _.clone @toJSON()
      if _.any @serverAttrs
        json = _.pick json, @serverAttrs

    parse: (response, options) ->
      parsed =
        response: response
