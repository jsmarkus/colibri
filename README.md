# Colibri MongoDB/Express CRUD framework

Use `colibri` if you need to create RESTful backend to you mongodb collections in quick and easy way.

![](https://github.com/jsmarkus/colibri/raw/master/kdpv.jpg)

```coffeescript
express = require 'express'
mongoose = require 'mongoose'
colibri = require 'colibri'

app = express.createServer()

app.use express.bodyParser()
app.use express.static "#{__dirname}/static"

mongoose.connect 'mongodb://localhost/colibriTodo'

#mongoose-related stuff: Schema and Model

TodoSchema = new mongoose.Schema
  title : String
  order : Number
  done  : type:Boolean, default:no

TodoModel = mongoose.model 'todo', TodoSchema

#And now - the magic!

colibri.createResource app,
  model : TodoModel

app.listen 3000

```