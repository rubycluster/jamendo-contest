define [
  'deps/bundles/jquery/bundle'
  'backbone_original'
  'backbone.stickit'
  'backbone-relational'
  'backbone-nested'
  'backbone-computedfields'
], (
  b$
  oBackbone
)->

  oBackbone
  oBackbone.$ = b$

  _.extend oBackbone.Model::,
    patch: (attrs = null) ->
      @save(attrs, patch: true, wait: true)

  _.extend oBackbone.RelationalModel::,
    fetchAllRelations: ->
      dfds = _.chain(@relations)
        .pluck('key')
        .map (key) =>
          @getAsync(key)
        .value()
      $.when(dfds...)

  oBackbone
