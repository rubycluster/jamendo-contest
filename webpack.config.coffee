path = require('path')
webpack = require('webpack')
autoprefixer = require('autoprefixer')
ExtractTextPlugin = require('extract-text-webpack-plugin')

require('dotenv').load()

config =

  context: path.resolve('app')
  devtool: '#source-map'

  entry:
    main: 'main'

  output:
    path: path.resolve('build')
    publicPath: 'build/'
    filename: '[name].js'
    chunkFilename: '[id].js'

  resolve:

    root: [
      path.resolve('app/scripts')
      path.resolve('app')
      path.resolve('.')
      path.resolve('bower_components')
    ]

    alias:
      'config':
        # path.join(__dirname, 'config', process.env.APP_ENV || 'test')
        'config/settings'
      'vent':
        'app/scripts/vent'
      'backbone_original':
        'node_modules/backbone/backbone.js'
      'jquery_original':
        'node_modules/jquery/dist/jquery.js'
      'marionette_original':
        'node_modules/backbone.marionette' +
          '/lib/backbone.marionette.js'
      'marionette':
        'deps/bundles/marionette/bundle'
      'moment_original':
        'node_modules/moment/moment.js'
      'moment':
        'deps/bundles/moment/original'
      'store_original':
        'node_modules/store/store.js'
      'store':
        'helpers/store'

    extensions: [
      ''
      '.webpack.js'
      '.web.js'
      '.js'
      '.json'
      '.coffee'
      '.hamlc'
      '.jade'
      '.styl'
      '.sass'
      '.css'
    ]

  module:

    noParse: /\.min\.js/

    loaders: [
      {
        test: /\.coffee$/
        loader: 'coffee'
      }
      {
        test: /\.json/
        loader: 'json'
      }
      {
        test: /\.hamlc$/
        loader: 'hamlc'
      }
      {
        test: /\.jade/
        loader: 'jade'
      }
      {
        test: /\.css$/
        loader:
          ExtractTextPlugin.extract(
            'style-loader',
            'css-loader',
            publicPath: ''
          )
      }
      {
        test: /\.styl$/
        loader:
          ExtractTextPlugin.extract(
            'style-loader',
            'css-loader!postcss-loader!stylus-loader',
            publicPath: ''
          )
      }
      {
        test: /\.s[ac]ss$/,
        loader:
          ExtractTextPlugin.extract(
            'style-loader',
            'css-loader!postcss-loader!sass-loader',
            publicPath: ''
          )
      }
      {
        test: /\.otf/
        loader:
          'file?name=public/fonts/[name].[ext]&prefix=font/&' +
          'mimetype=application/x-font-opentype'
      }
      {
        test: /\.eot/
        loader:
          'file?name=public/fonts/[name].[ext]&prefix=font/&' +
          'mimetype=application/vnd.ms-fontobject'
      }
      {
        test: /\.ttf/
        loader:
          'file?name=public/fonts/[name].[ext]&prefix=font/&' +
          'mimetype=application/x-font-truetype'
      }
      {
        test: /\.svg/
        loader:
          'file?name=public/fonts/[name].[ext]&prefix=font/&' +
          'mimetype=image/svg+xml'
      }
      {
        test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/
        loader:
          'file?name=public/fonts/[name].[ext]&prefix=font/&' +
          'mimetype=application/font-woff'
      }
      {
        test: /\.png$/
        loader: 'file?prefix=img/&mimetype=image/png'
      }
      {
        test: /\.jpg$/
        loader: 'file?prefix=img/&mimetype=image/jpg'
      }
      {
        test: /\.gif$/
        loader: 'file?prefix=img/&mimetype=image/gif'
      }
    ]

  postcss: ->
    [
      autoprefixer
    ]

  externals: {}

  plugins: [
      new webpack.ProvidePlugin(
        $:
          'deps/bundles/jquery/original'
        jQuery:
          'deps/bundles/jquery/original'
        'window.jQuery':
          'deps/bundles/jquery/original'
        _:
          'deps/bundles/underscore/bundle'
        Backbone:
          'deps/bundles/backbone/bundle'
        Marionette:
          'deps/bundles/marionette/original'
        moment:
          'deps/bundles/moment/bundle'
        locale:
          'scripts/locales/locale'
        config:
          'config/settings'
      )
    ,
      new ExtractTextPlugin('[name].css')
  ]

  node:
    fs: 'empty'

switch process.env.NODE_ENV

  when 'development', 'test'
    config.cache = true
    config.debug = true
    config.output.pathinfo = true
    config.devServer =
      hot: true
      inline: true
      progress: true
      stats:
        warnings: false
        chunks: false
        children: false
    config.plugins = config.plugins.concat [
        new webpack.HotModuleReplacementPlugin()
    ]

  when 'production'
    config.bail = true
    config.plugins = config.plugins.concat [
        new webpack.optimize.DedupePlugin()
      ,
        new webpack.optimize.UglifyJsPlugin(
          output:
            comments: false
        )
    ]

module.exports = config
