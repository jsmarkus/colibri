# Colibri MongoDB/Express CRUD framework

Use `colibri` if you need to create RESTful backend to you mongodb collections in quick and easy way.

![](https://github.com/jsmarkus/colibri/raw/master/kdpv.jpg)

Let's write a backend for well-known ToDo application (see `example/todo`)

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
  model       : TodoModel
  plainOutput : yes

app.listen 3000

```

`colibri` adds the following routes automatically to your Express app:

 * `GET /todo` - get a list of items
 * `POST /todo` - create new item
 * `GET /todo/:id` - get an item with corresponding _id 
 * `PUT /todo/:id` - save an item with corresponding _id
 * `DELETE /todo/:id` - delete an item with corresponding _id

We have a todo-server ready to use with - for example - Backbone.