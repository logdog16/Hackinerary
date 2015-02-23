express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
Notification  = mongoose.model 'Notification'

module.exports = (app) ->
  app.use '/', router

# GET requests
router.get '/', baseHandler
router.get '/notifications', streamHandler
router.get '/director', directorHandler

# POST request
router.post '/addNotification', addHandler

###############################################
#             Callback Handlers               #
###############################################

#####
# router.get '/' Callback
#
# Handler for '/', which I've been referring to
# as the base. Will redirect to the notifications
# stream.
baseHandler: (req, res, next) ->
    router.location '/notifications'
    router.redirect '/notifications'

#####

#####
# router.get '/notifications'
#
# Displays the stream of notifications with the
# newest at the top.
streamHandler: (req, res, next) ->
    Notification.find (err, notifications) ->
      return next(err) if err
      res.render 'notificationStream',
        notifications: notifications.reverse

#####

#####
# router.get '/director' callback
#
# Render the director new notification form.
# The submit button will call the addHandler
# at '/addNotification'.
directorHandler: (req, res, next) ->
    res.render '/directorAddForm'

#####

#####
# router.get '/addNotification' callback
#
# '/addNotification' handler
# Gets the Title, Fuzzy Time, and Description
# out of the form.
addHandler: (req, res, next) ->

    nTitle = req.body.notificationTitle
    nDesc = req.body.notificationDesc
    nTime = req.body.notificationTime

    # Creates a new Notification schema object
    # using the request body form parameters.
    noti = new Notification(
        title: nTitle
        fuzzytime: nTime
        description: nDesc
    )

    # Saves the Notification model object.
    noti.save (err, newnotification) ->
        return next(err) if err

        # Render the confirmation screen and pass
        # the generated id as a parameter.
        res.render 'directorConfirmation',
            notificationID: newnotification._id

#####
