express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
Notification  = mongoose.model 'Notification'

Util = {}
Notifications = {}

module.exports = (app) ->
  app.use '/', router

# Returns the given object in reverse order.
Util.reverseObject = reverseObject = (obj) ->
  (Object.keys(obj).map (key) ->
    return obj[key]).reverse()

###############################################
#             Callback Handlers               #
###############################################

#####
# router.get '/' Callback
#
# Handler for '/', which I've been referring to
# as the base. Will redirect to the notifications
# stream.
Notifications.baseHandler = baseHandler = (req, res, next) ->
  res.location '/notifications'
  res.redirect '/notifications'

#####

#####
# router.get '/notifications'
#
# Displays the stream of notifications with the
# newest at the top.
Notifications.streamHandler = streamHandler = (req, res, next) ->
  Notification.find (err, notifications) ->
    return next(err) if err
    res.render 'notificationStream',
      notifications: reverseObject(notifications)

#####

#####
# router.get '/director' callback
#
# Render the director new notification form.
# The submit button will call the addHandler
# at '/addNotification'.
Notifications.directorHandler = directorHandler = (req, res, next) ->
  res.render 'directorAddForm'

#####

#####
# router.get '/addNotification' callback
#
# '/addNotification' handler
# Gets the Title, Fuzzy Time, and Description
# out of the form.
Notifications.addHandler = addHandler = (req, res, next) ->

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

#####
# router.get '/searchNotification' callback
#
# '/searchNotification' handler
# Renders the page where directors can enter the 3 character id that
# notifications were give. The database is then queried. If the notification
# is found, then we direct them to the update page, where they can change
# the notification's fields. Else, they are given an error page and can enter
# another query.
Notifications.searchHandler = searchHandler = (req, res, next) ->

  res.render 'searchNotification'

#####

#####
# router.get '/updateNotificationForm' callback
#
# '/updateNotificationForm' handler
# Accepts a notification id and, if it is present in the
# database, allows the user to update it.
Notifications.updateNotificationFormHandler =
updateNotificationFormHandler = (req, res, next) ->

  Notification.findById(
    _id: req.body.queryid,
    (err, notification) ->
      return next(err) if err

      console.log 'Notification found: ' + notification.title

      if notification
        res.render 'updateNotificationForm', notification: notification

      else
        res.render 'notificationNotFound', queryid: req.body.queryid
    )

#####

#####
# router.put '/updateNotification' callback
#
# '/updateNotification' handler
# Accepts the form input and edits the notification
# according to what the user specified.
Notifications.updateNotificationHandler =
updateNotificationHandler = (req, res, next) ->

  nID = req.body.notificationID
  nTitle = req.body.notificationTitle
  nDesc = req.body.notificationDesc
  nTime = req.body.notificationTime

  notificationFields =
    title: nTitle
    fuzzytime: nTime
    description: nDesc

  Notification.findByIdAndUpdate(nID, notificationFields, (err, notification) ->
    return next(err) if err

    res.render 'directorConfirmation',
      notificationID: notification._id
    )
    
# GET requests
router.get '/', Notifications.baseHandler
router.get '/notifications', Notifications.streamHandler
router.get '/director', Notifications.directorHandler
router.get '/searchNotification', Notifications.searchHandler

# PUT requests
router.put '/updateNotification',
Notifications.updateNotificationHandler

# POST request
router.post '/addNotification', Notifications.addHandler
router.post '/updateNotificationForm',
Notifications.updateNotificationFormHandler
