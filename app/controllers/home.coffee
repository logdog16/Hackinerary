express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
Notification = require '../models/notification'
Notification = mongoose.model 'Notification'


notifications = require '../controllers/notifications'

module.exports = (app) ->
  app.use '/', router
  app.use '/api', router
  app.post '/api', notifications.create
  app.get '/api', notifications.retrieve
  app.get '/api/:id', notifications.retrieve
  app.put '/api/:id', notifications.update
  app.delete '/api/:id', notifications.delete

router.get '/', (req, res, next) ->

  res.send('Ayye lmao')

router.get '/api', (req, res, next) ->
  res.send(404)
