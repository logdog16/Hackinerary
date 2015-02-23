path     = require 'path'
rootPath = path.normalize __dirname + '/..'
env      = process.env.NODE_ENV || 'development'

config =
  development:
    root: rootPath
    app:
      name: 'hackinerary'
    port: 3000
    db: 'mongodb://localhost/hackinerary-development'

  test:
    root: rootPath
    app:
      name: 'hackinerary'
    port: 3000
    db: 'mongodb://localhost/hackinerary-test'

  production:
    root: rootPath
    app:
      name: 'hackinerary'
    port: 3000
    db: 'mongodb://localhost/hackinerary-production'

module.exports = config[env]
