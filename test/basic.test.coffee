express = require 'express'
mongoose = require 'mongoose'
colibri = require '../'
request = require 'superagent'

app = express.createServer()

app.use express.bodyParser()

mongoose.connect 'mongodb://localhost/colibriTest'

ItemSchema = new mongoose.Schema
	title : String
	body  : String
	order : Number

ItemModel = mongoose.model 'item', ItemSchema

colibri.createResource app,
	model : ItemModel

app.listen 3000

URL = 'http://127.0.0.1:3000'


before (done)->
	ItemModel.remove {}, ()->
		done()

itemId = null

describe 'Basic REST API', ->

	it 'should create item', (done)->
		request
			.post("#{URL}/item")
			.send(title: 'foo', body:'bar')
			.end (res)->
				itemId = res.body._id

				res.status.should.equal 200
				res.body.should.have.property 'title', 'foo'
				res.body.should.have.property 'body', 'bar'
				done()

	it 'should update item', (done)->
		request
			.put("#{URL}/item/#{itemId}")
			.send(title: 'aaa')
			.end (res)->
				res.status.should.equal 200
				res.body.should.have.property 'title', 'aaa'
				res.body.should.have.property 'body', 'bar'
				done()


	it 'should get item', (done)->
		request
			.get("#{URL}/item/#{itemId}")
			.end (res)->
				res.status.should.equal 200
				res.body.should.have.property 'title', 'aaa'
				res.body.should.have.property 'body', 'bar'
				done()

	it 'should get a list of items', (done)->
		request
			.get("#{URL}/item")
			.end (res)->
				res.status.should.equal 200
				res.body.should.be.an.instanceof Array
				res.body.should.have.lengthOf 1
				res.body[0].should.have.property 'title', 'aaa'
				res.body[0].should.have.property 'body', 'bar'
				done()

	it 'should delete item', (done)->
		request
			.del("#{URL}/item/#{itemId}")
			.end (res)->
				res.status.should.equal 204
				request
					.get("#{URL}/item/#{itemId}")
					.end (res)->
						res.status.should.equal 404
						done()