defaults =
  api: url: undefined

module.exports =

  development: $.extend true, {}, defaults,
    api: url: '//localhost:3005'

  test: $.extend true, {}, defaults,
    api: url: ''

  staging: $.extend true, {}, defaults,
    api: url: 'https://api.s.10ideas.club'

  production: $.extend true, {}, defaults,
    api: url: 'https://api.10ideas.club'
