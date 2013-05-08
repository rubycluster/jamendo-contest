define [
  'jquery'
  'underscore'
], ($, _) ->

  class BaseAPI

    constructor: (args) ->
      @initialize args

    baseUrl: ''

    dataDefaults: {}

    initialize: (options) ->
      @options = options
      @prepareData()
      @response = {}
      @result = {}
      @

    request: ->
      dfr = $.ajax
        type: 'GET'
        url: @baseUrl
        data: @data
        dataType: 'json'
      dfr.done @ajaxCallback
      dfr

    ajaxCallback: (data, status, xhr) =>
      @response = arguments
      @prepareResult()

    prepareData: ->
      @data = $.extend true, {}, @dataDefaults, @options.data

    prepareResult: ->
      @result = @response[0]
