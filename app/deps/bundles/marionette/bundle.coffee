define [
  'deps/bundles/backbone/bundle'
  './original'
], (
  bBackbone
  oMarionette
)->

  oMarionette
  oMarionette.Backbone = bBackbone
  bBackbone.Marionette = oMarionette
  oMarionette
