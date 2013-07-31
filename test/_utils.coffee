express = require 'express'
mongoose = require 'mongoose'

mongoose.connect 'mongodb://localhost/colibriTest'

ItemSchema = new mongoose.Schema
	title : String
	body  : String
	order : Number

ItemModel = mongoose.model 'item', ItemSchema


app = express.createServer()
app.use express.bodyParser()
app.listen 3000

#-----------------------
#-----------------------
#-----------------------
#-----------------------

exports.ItemSchema = ItemSchema
exports.ItemModel  = ItemModel
exports.app        = app
exports.URL        = 'http://127.0.0.1:3000'
