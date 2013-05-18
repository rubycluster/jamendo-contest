define [
  'config/settings/global'
  'config/settings/keys'
], (globalSettings, keysSettings) ->

  settings =
    global: globalSettings
    keys: keysSettings
