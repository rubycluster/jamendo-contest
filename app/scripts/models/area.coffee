define [
  'models/base'
  'syncs/geocoding'
], (
  BaseModel
  GeocodingSync
) ->

  class Area extends BaseModel

    defaults:
      address: undefined
      position:
        lat: undefined
        lng: undefined
      background: undefined

    syncer: GeocodingSync

    serverAttrs: [
      'address'
      'position'
    ]

    parse: (response, options) ->
      parsed = super
      parsed.position = @parsePosition(response)
      parsed.address = @parseAddress(response)
      parsed.country = @parseCountry(response)
      parsed

    parsePosition: (response) ->
      data = response?.results
      data = data? && _(data).first()?.geometry?.location
      data || {}

    parseAddress: (response) ->
      data = response?.results
      data = data && _(data).first()?.address_components
      data = data? && _(data).find (i) ->
        _(i.types).include('locality')
      data = data?.long_name
      data || ''

    parseCountry: (response) ->
      data = response?.results
      data = data && _(data).first()?.address_components
      data = data? && _(data).find (i) ->
        _(i.types).include('country')
      data = data?.long_name
      data || ''
