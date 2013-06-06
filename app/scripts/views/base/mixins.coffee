define [
], () ->

  ViewsMixins =

    assignSubView: (selector, view) ->
      if _.isObject(selector)
        selectors = selector
      else
        selectors = {}
        selectors[selector] = view
      return unless selectors
      _.each selectors, (view, selector) ->
        if view && @$(selector)
          view.setElement( @$(selector) ).render()
      , this

    hideView: ->
      @onBeforeHide()
      $(@el).hide()
      @onHide()

    showView: ->
      $(@el).slideDown('fast')

    onBeforeRender: ->
      if @options.hiddenOnce
        @options.hiddenOnce = false
        @hideView()

    onBeforeHide: ->

    onHide: ->

    isHidden: ->
      $(@el).filter(':hidden').length > 0
