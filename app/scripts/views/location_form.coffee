define [
  'views/base/item_view'
  'templates/location_form'
  'apis/geolocation'
  'apis/reverse_geocoding'
], (BaseItemView, template, GeolocationAPI, ReverseGeocodingAPI) ->

  class LocationFormView extends BaseItemView

    template: template

    el: '#location-form'

    ui:
      form: 'form'
      input: '#location'
      geolocate: '#geolocate'
      play: '#location-submit'

    triggers:
      'submit form': 'location:submit'
      'click #location-submit': 'location:submit'
      'click #geolocate': 'location:geolocate'

    initialize: ->
      @initTriggers()
      super
      @

    initTriggers: ->
      @on 'location:submit', @locationSubmit
      @on 'location:geolocate', @locationGeolocate
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
        $(@ui.input).val api.result
      dfr

    locationFound: ->
