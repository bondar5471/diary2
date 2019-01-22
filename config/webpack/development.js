process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()

config.action_cable.url = 'ws://localhost:3000/cable'
config.action_cable.allowed_request_origins = [ 'http://localhost:3000', 'http://127.0.0.1:3000' ]
