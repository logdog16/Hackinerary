mongoose = require 'mongoose'

Notification = new mongoose.Schema(
  title: String
  time: String
  category: Number
  desc: String
  ID: Number
  ong: Boolean
  )

mongoose.model "Notification", Notification
