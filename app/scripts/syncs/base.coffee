define [
  'backbone'
], (Backbone) ->

  class BaseSync

    paramsDefaults:
      type: 'GET'
      contentType: 'application/json'
      dataType: 'jsonp'
      emulateHTTP: Backbone.emulateHTTP
      emulateJSON: Backbone.emulateJSON

    baseUrl: undefined
    dataDefaults: {}

    process: ->
      @sync.apply @, arguments[0]

    sync: (method, model, options = {}) ->
      params = $.extend true, {}, @paramsDefaults, options.params || {}
      params.url = @baseUrl
      data = $.extend true, {}, @dataDefaults, (options.attrs || model.toServerJSON(options))
      params.data = @prepareData data
      xhr = options.xhr = Backbone.ajax params
      xhr.done (response, status, xhr) =>
        model.set model.parse(response)
        model.trigger "parsed", model
      model.trigger "request", model, xhr, options
      xhr

    prepareData: (data = {}) ->
      _.clone data
