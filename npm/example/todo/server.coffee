express = require 'express'
# express = require './mock/express'
mongoose = require 'mongoose'
colibri = require '../../'

app = express.createServer()

app.use express.bodyParser()
app.use express.static "#{__dirname}/static"

mongoose.connect 'mongodb://localhost/colibriTodo'

TodoSchema = new mongoose.Schema
	title : String
	order : Number
	done  : type:Boolean, default:no

TodoModel = mongoose.model 'todo', TodoSchema

resource = colibri.createResource
	model : TodoModel

resource.express app

app.listen 3000