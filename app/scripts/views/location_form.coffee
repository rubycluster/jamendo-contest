define [
  'views/base/item_view'
  'templates/location_form'
  'models/area'
  'apis/geolocation'
  'apis/reverse_geocoding'
], (BaseItemView, template, Area, GeolocationAPI, ReverseGeocodingAPI) ->

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
      @initTriggers()
      super
      @model ||= new Area
      @

    initTriggers: ->
      @on 'location:submit', @setSpinner
      @on 'location:submit', _.throttle(@locationSubmit, @options.inputDelay)
      @on 'location:geolocate', _.throttle(@locationGeolocate, @options.geolocateDelay)
      @on 'location:change', @locationChange

    onRender: ->
      @triggerGeolocate()
      @ui.input.focus()

    locationGeolocate: ->
      api = new GeolocationAPI()
      api.geolocate()
        .done (position) =>
          @locationReverseGeocoding position
        .fail (message) =>
          alert message

    locationReverseGeocoding: (position) ->
      api = new ReverseGeocodingAPI
        data: position
      api.request().done =>
        @model.unset 'address',
          silent: true
        @model.set 'address', api.result

    setSpinner: (spin = true) ->
      el = @ui.geolocate.find('i')
      if spin
        el.addClass('spin')
      else
        el.removeClass('spin')

    triggerGeolocate: ->
      $(@ui.geolocate).trigger 'click'

    locationSubmit: ->
      address = $(@ui.input).val()
      @model.set 'address', address
      @locationFix(address)

    locationFix: (address) ->
      api = new ReverseGeocodingAPI
        data:
          address: address
      dfr = api.request()
      dfr.done =>
        result = api.result
        if _.any result
          @setValidForm true
          @model.set 'address', result
          position = api.response[0].results[0].geometry.location
          @model.set 'position', position
        else
          @setValidForm false
        @setSpinner false
        result
      dfr

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
