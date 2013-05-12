define [
  'backbone'
], (Backbone) ->

  class BaseSync

    constructor: ->
      @sync.apply @, arguments[0]

    paramsDefaults:
      type: 'GET'
      contentType: 'application/json'
      dataType: 'jsonp'
      emulateHTTP: Backbone.emulateHTTP
      emulateJSON: Backbone.emulateJSON

    prepareData: ->
    baseUrl: undefined
    dataDefaults: {}

    sync: (method, model, options = {}) ->
      params = $.extend true, {}, @paramsDefaults, options.params || {}
      params.url = @baseUrl
      data = $.extend true, {}, @dataDefaults, (options.attrs || model.toServerJSON(options))
      params.data = @prepareData data
      xhr = options.xhr = Backbone.ajax params
      xhr.done (response, status, xhr) =>
        model.set model.parse(response)
      model.trigger "request", model, xhr, options
      xhr

