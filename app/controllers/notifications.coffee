mongoose = require 'mongoose'

Notification = require ('../models/notification.coffee')

exports.retrieve = (req, res) ->
  Resource = mongoose.model('Notification')

  if req.params.id?
    Resource.findById req.params.id, (err, resource) ->
      res.send(500, { error: err }) if err?
      res.send(resource) if resource?
      res.send(404)
  else
    Resource.find {}, (err, coll) ->
      res.send(coll)


exports.create = (req, res) ->

  r = new Notification(req.body)
  r.save (err, resource) ->
    res.send(500, { error: err }) if err?
    console.log(req.body)
    res.send(resource)

exports.update = (req, res) ->
  Resource = mongoose.model('Notification')
  fields = req.body

  Resource.findByIdAndUpdate req.params.id, { $set: fields }, (err, resource) ->
    res.send(500, { error: err }) if err?
    res.send(resource) if resource?
    res.send(404)

exports.delete = (req, res) ->
  Resource = mongoose.model('Notification')

  Resource.findByIdAndRemove req.params.id, (err, resource) ->
    res.send(500, { error: err }) if err?
    res.send(200) if resource?
    res.send(404)

exports.test = (req, res) ->
  res.send(200)