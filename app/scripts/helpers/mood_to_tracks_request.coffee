define [
  'underscore'
], (_) ->

  class MoodToTracksRequest

    constructor: ->
      @initialize.apply @, arguments

    initialize: (items = {}) ->
      @items = items
      @result = {}
      @

    convert: ->
      @setDummyAll()
      @

    setDummyAll: ->
      @result =
        acousticelectric: 'acoustic'
        gender: 'female'
