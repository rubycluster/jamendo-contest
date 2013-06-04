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
        .done(@locationReverseGeocoding)
        .fail(alert)

    locationReverseGeocoding: (position) ->
      @model.unset 'address'
      @model.unset 'position',
        silent: true
      @model.set 'position', position,
        silent: true
      @model.fetch({silent: true})
        .done =>
          @model.trigger 'change:address', @model, @model.get('address')

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
      dfd = @model.fetch
        attrs:
          address: address
      dfd.done (response) =>
        if _.any response.results
          @setValidForm true
        else
          @setValidForm false
        @setSpinner false
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
