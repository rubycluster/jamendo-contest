gulp = require('gulp-help')(require('gulp'),
  hideEmpty: true
  hideDepsMessage: true
)
gutil = require('gulp-util')
clean = require('gulp-clean')
plumber = require('gulp-plumber')
coffeelint = require('gulp-coffeelint')
stylish = require('coffeelint-stylish')
webpack = require('webpack')
gulpWebpack = require('gulp-webpack')
webpackConfig = require('./webpack.config.js')

gulp.task 'default', false, ['help']

gulp.task 'build', 'Build application',
[
  'webpack:build'
  'dist:prepare'
]

gulp.task 'webpack:build', false, ['build:clean'], (callback) ->

  gulp
    .src([
      './app/app'
    ])
    .pipe(
      plumber(
        errorHandler: (err) ->
          gutil.log '[error]', err.toString(colors: true)
          process.exit(1)
      )
    )
    .pipe(gulpWebpack(webpackConfig), webpack)
    .pipe(gulp.dest('build/'))

gulp.task 'dist:prepare', false, ['dist:clean', 'webpack:build'], ->
  gulp
    .src([
      'build/**'
      'index.html'
      'favicon.ico'
      'robots.txt'
      'server.js'
    ], base: '.')
    .pipe(gulp.dest('dist/'))

gulp.task 'dist:clean', false, ->
  gulp
    .src('dist', read: false)
    .pipe(clean())

gulp.task 'build:clean', false, ->
  gulp
    .src('build', read: false)
    .pipe(clean())

gulp.task 'lint', 'Lint codebase',
[
  'lint:coffee'
]

gulp.task 'lint:coffee', false, ->
  gulp
    .src([
      './app/**/*.coffee'
    ])
    .pipe(coffeelint('./coffeelint.json'))
    .pipe(coffeelint.reporter(stylish))
    .pipe(coffeelint.reporter('failOnWarning'))
