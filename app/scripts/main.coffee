#global require

"use strict"

require.config

  paths:
    app: "app"
    app_deps: "config/app_deps"
    jquery: "../components/jquery/jquery"
    backbone: "../components/backbone/backbone"
    underscore: "../components/underscore/underscore"
    bootstrap: "vendor/bootstrap"
    backbone_marionette: "../components/backbone.marionette/lib/backbone.marionette"
    groundwork: "vendor/groundwork.all"
    moment: "../components/moment/moment"
    mediaelement: "../components/mediaelement/build/mediaelement-and-player"

  shim:

    jquery:
      exports: '$'

    underscore:
      exports: "_"

    backbone:
      exports: "Backbone"
      deps: [
        "underscore"
        "jquery"
      ]

    backbone_marionette:
      exports: "Backbone.Marionette"
      deps: ["backbone"]

    mediaelement:
      deps: ["jquery"]

    bootstrap:
      exports: "jquery"
      deps: ["jquery"]

    "vendor/jquery-modals":
      deps: ["jquery"]
    "vendor/jquery-popover":
      deps: ["jquery"]
    "vendor/jquery-responsiveTables":
      deps: ["jquery"]
    "vendor/jquery-responsiveText":
      deps: ["jquery"]
    "vendor/jquery-tooltip":
      deps: ["jquery"]
    "vendor/jquery.cycle2":
      deps: ["jquery"]

    groundwork:
      exports: "GroundworkCSS"
      deps: [
        "jquery"
        "vendor/jquery-modals"
        "vendor/jquery-popover"
        "vendor/jquery-responsiveTables"
        "vendor/jquery-responsiveText"
        "vendor/jquery-tooltip"
        "vendor/jquery.cycle2"
      ]

    app:
      deps: [ 'app_deps' ]

require ["app", "jquery", "app_deps"], (app, $) ->
  $ ->
    window.app = app
    app.start()
