express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
Article  = mongoose.model 'Article'

module.exports = (app) ->
  app.use '/', router
  app.use '/api', router
  app.post '/widgets', widgets.create
  app.get '/widgets', widgets.retrieve
  app.get '/widgets/:id', widgets.retrieve
  app.put '/widgets/:id', widgets.update
  app.delete'/widgets/:id', widgets.delete

router.get '/', (req, res, next) ->

  Article.find (err, articles) ->
    return next(err) if err
    res.render 'index',
      title: 'Ayye Lmao'
      articles: articles

router.get '/api', (req, res, next) ->
  res.send(404)
