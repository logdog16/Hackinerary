# Notification db model

mongoose = require 'mongoose'
ShortId = require 'mongoose-shortid'

Schema   = mongoose.Schema

NotificationSchema = new Schema(
    _id:
        type: ShortId
        len: 3
        alphabet: 'abcdefghijklmnopqrstuvwxyz'
    title: String
    fuzzytime: Number
    description: String
)

NotificationSchema.virtual('date')
  .get (-> this._id.getTimestamp())

mongoose.model 'Notification', NotificationSchema
