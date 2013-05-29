define [
  'views/base/item_view'
  'templates/bookmarks'
  'models/area'
  'config/settings'
  'i18n!nls/locale'
], (BaseItemView, template, Area, settings, locale) ->

  class BookmarksView extends BaseItemView

    template: template

    el: '#bookmarks'

    triggers:
      'click a.button-hide': 'bookmarks:toggle'
      'click a.button-show': 'bookmarks:toggle'

    modelEvents:
      'change:position': 'render'

    addthisConfig:
      ui:
        username: settings.keys.addthis.username
        ui_click: true
      share:
        url: settings.global.app.url
        title: locale.share.title
        description: locale.share.description

    initialize: ->
      @initTriggers()
      super
      @model ||= new Area
      @

    initTriggers: ->
      @on 'bookmarks:toggle', @toggleView

    onBeforeRender: ->
      @hideView()

    onRender: ->
      @isValidToShow() && @showView()

    showView: ->
      ui = $.extend true, {}, @addthisConfig.ui
      share = $.extend true, {}, @addthisConfig.share
      addthis?.toolbox @el, ui, share
      super

    isValidToShow: ->
      addthis? and _.any(@model.get('address'))

    toggleView: ->
      $(@el).toggleClass 'collapsed'
