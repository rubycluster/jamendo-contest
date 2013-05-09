define [
  'views/base/item_view'
  'templates/location_form'
  'apis/geolocation'
  'apis/reverse_geocoding'
], (BaseItemView, template, GeolocationAPI, ReverseGeocodingAPI) ->

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

    initialize: ->
      @initTriggers()
      super
      @

    initTriggers: ->
      @on 'location:submit', _.throttle(@locationSubmit, @options.inputDelay)
      @on 'location:geolocate', _.throttle(@locationGeolocate, @options.geolocateDelay)
      @on 'location:change', @locationChange
      @on 'location:found', @locationFound

    onRender: ->
      @triggerGeolocate()
      @ui.input.focus()

    locationGeolocate: ->
      @locationGeolocateSpinner true
      api = new GeolocationAPI()
      api.geolocate()
        .done (position) =>
          @locationReverseGeocoding position
        .fail (message) =>
          @locationGeolocateSpinner false
          alert message

    locationReverseGeocoding: (position) ->
      api = new ReverseGeocodingAPI
        data: position
      api.request().done =>
        $(@ui.input).val api.result
        @locationGeolocateSpinner false

    locationGeolocateSpinner: (spin = true) ->
      el = @ui.geolocate.find('i')
      if spin
        el.addClass('spin')
      else
        el.removeClass('spin')

    triggerGeolocate: ->
      $(@ui.geolocate).trigger 'click'

    locationSubmit: ->
      address = $(@ui.input).val()
      @locationFix(address)
        .done =>
          @trigger 'location:found'

    locationFix: (address) ->
      api = new ReverseGeocodingAPI
        data:
          address: address
      dfr = api.request()
      dfr.done =>
        result = api.result
        if _.any result
          @setValidForm true
          $(@ui.input).val result
        else
          @setValidForm false
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

    locationFound: ->
