express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
Notifications = require './Notifications'
Notification  = mongoose.model 'Notification'

module.exports = (app) ->
  app.use '/', router

# GET requests
router.get '/', Notifications.baseHandler
router.get '/notifications', Notifications.streamHandler
router.get '/director', Notifications.directorHandler

router.post '/addNotification', Notifications.addHandler
