path     = require 'path'
rootPath = path.normalize __dirname + '/..'
env      = process.env.NODE_ENV || 'development'

config =
  development:
    root: rootPath
    app:
      name: 'hackinerary'
    port: 3000
    db: 'mongodb://nitrodev:hackme@ds052837.mongolab.com:52837/hack_dev'

  test:
    root: rootPath
    app:
      name: 'hackinerary'
    port: 3000
    db: 'mongodb://localhost/hackinerary_test'

  production:
    root: rootPath
    app:
      name: 'hackinerary'
    port: 3000
    db: 'mongodb://localhost/hackinerary_production'

module.exports = config[env]
