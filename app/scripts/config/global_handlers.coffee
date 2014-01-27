define [
], () ->

  GlobalHandlers =

    init: (@app) ->
      @all()
      window.cordova && @cordova() || @browser()

    all: ->

    browser: ->

    cordova: ->

      $(document)

        .on 'click', '[target="_blank"]', (event) ->
          event.preventDefault()
          url = $(event.target).attr('href')
          window.open(url, '_system')
          false

        .on 'backbutton', ->
          navigator.notification.confirm 'Do you really want to exit?', ( (buttonIndex) ->
            navigator.app.exitApp()  if buttonIndex is 2
          ), 'Exit', ['Cancel', 'OK']
