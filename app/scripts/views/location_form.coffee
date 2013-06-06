define [
  'views/base/item_view'
  'templates/location_form'
  'models/area'
  'apis/geolocation'
], (BaseItemView, template, Area, GeolocationAPI) ->

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

    modelEvents:
      'change:address': 'onAddressChange'

    initialize: ->
      @initBindings()
      @initTriggers()
      super
      @model ||= new Area
      @

    initBindings: ->
      _.bindAll @, 'locationReverseGeocoding'

    initTriggers: ->
      @on 'location:submit', _.throttle(@locationSubmit, @options.inputDelay)
      @on 'location:geolocate', _.throttle(@locationGeolocate, @options.geolocateDelay)
      @on 'location:change', @locationChange

    onRender: ->
      @triggerGeolocate()
      @ui.input.focus()

    locationGeolocate: ->
      api = new GeolocationAPI()
      api.geolocate()
        .done(@locationReverseGeocoding)
        .fail(alert)

    locationReverseGeocoding: (position) ->
      @model.unset 'address'
      @model.touch 'position', position
      dfd = @model.fetch
        silent: true
      dfd.done =>
        @model.touch 'address'
        @model.touch 'position'
      dfd

    triggerGeolocate: ->
      $(@ui.geolocate).trigger 'click'

    locationSubmit: ->
      address = $(@ui.input).val()
      @model.set 'address', address
      @locationFix(address)

    locationFix: (address) ->
      @model.unset 'position',
        silent: true
      dfd = @model.fetch
        silent: true
      dfd.done (response) =>
        @model.touch 'address'
        @model.touch 'position'
        if _.any response.results
          @setValidForm true
        else
          @setValidForm false
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
      $(@ui.input).val value
