mongoose = require 'mongoose'

Notification = new mongoose.Schema(
  title: String
  time: Number
  category: Number
  description: String
  ID: Number
  ongoing: Boolean
  )


Notification = mongoose.model "Notification", Notification, "notifications"

#module.exports = Notification
