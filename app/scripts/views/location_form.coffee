define [
  'views/base/item_view'
  'templates/location_form'
  'models/area'
  'apis/geolocation'
  'vent'
], (
  BaseItemView
  template
  Area
  GeolocationAPI
  vent
) ->

  class LocationFormView extends BaseItemView

    options:
      inputDelay: 5000
      geolocateDelay: 4000

    template: template

    el: '#location-form'

    ui:
      form: 'form'
      row: '.row'
      input: '#location'
      geolocate: '#geolocate'
      play: '#location-submit'

    triggers:
      'submit form': 'location:submit'
      'click #location-submit': 'location:submit'
      'click #geolocate': 'location:geolocate'
      'input #location': 'location:change'
      'click #link-help': 'help:toggle'

    modelEvents:
      'change:address': 'onAddressChange'
      'change:position': 'onPositionChange'

    initialize: ->
      @initBindings()
      @initTriggers()
      super
      @model ||= new Area
      @

    initBindings: ->
      _.bindAll(@, 'locationReverseGeocoding')

    initTriggers: ->
      @on 'location:submit',
        _.throttle(@locationSubmit, @options.inputDelay)
      @on 'location:geolocate',
        _.throttle(@locationGeolocate, @options.geolocateDelay)
      @on('location:change', @locationChange)
      @on 'help:toggle', ->
        vent.trigger('help:toggle')

    onRender: ->
      @triggerGeolocate()
      @ui.input.focus()

    locationGeolocate: ->
      api = new GeolocationAPI()
      api.geolocate()
        .done(@locationReverseGeocoding)
        .fail(alert)

    locationReverseGeocoding: (position) ->
      @model.unset('address')
      dfd = @model.fetch
        attrs:
          position: position
        silent: true
      dfd.done =>
        @model.touch('address')
      dfd

    triggerGeolocate: ->
      $(@ui.geolocate).trigger('click')

    locationSubmit: ->
      address = $(@ui.input).val()
      @model.set('address', address)
      @locationFix(address)

    locationFix: (address) ->
      @model.unset 'position',
        silent: true
      dfd = @model.fetch
        silent: true
      dfd.done (response) =>
        @model.touch('address')
        @model.touch('position')
        if _.any(response.results)
          @setValidForm(true)
        else
          @setValidForm(false)
      dfd

    setValidForm: (valid = true) ->
      if valid
        @ui.row
          .removeClass('invalid')
          .addClass('valid')
      else
        @ui.row
          .removeClass('valid')
          .addClass('invalid')

    locationChange: ->
      @ui.row
        .removeClass('valid')
        .removeClass('invalid')

    onAddressChange: (model, value) ->
      $(@ui.input).val(value)

    onPositionChange: (model, value) ->
      @trigger('location:change:position', model, value)
