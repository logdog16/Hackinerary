mongoose = require 'mongoose'

Notification = new mongoose.Schema(
  title: String
  time: Number
  category: Number
  desc: String
  ID: Number
  ong: Boolean
  )


Noti = mongoose.model "Notification", Notification, "notifications"

module.exports = Noti
