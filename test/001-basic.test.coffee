colibri = require '../'
request = require 'superagent'

utils = require './_utils'


resource = colibri.createResource
	model : utils.ItemModel

resource.express utils.app


itemId = null



describe 'Basic REST API', ->

	before (done)->
		utils.ItemModel.remove {}, ()->
			done()

	it 'should create item', (done)->
		request
			.post("#{utils.URL}/item")
			.send(title: 'foo', body:'bar')
			.end (res)->
				itemId = res.body._id

				res.status.should.equal 200
				res.body.should.have.property 'title', 'foo'
				res.body.should.have.property 'body', 'bar'
				done()

	it 'should update item', (done)->
		request
			.put("#{utils.URL}/item/#{itemId}")
			.send(title: 'aaa')
			.end (res)->
				res.status.should.equal 200
				res.body.should.have.property 'title', 'aaa'
				res.body.should.have.property 'body', 'bar'
				done()


	it 'should get item', (done)->
		request
			.get("#{utils.URL}/item/#{itemId}")
			.end (res)->
				res.status.should.equal 200
				res.body.should.have.property 'title', 'aaa'
				res.body.should.have.property 'body', 'bar'
				done()

	it 'should get a list of items', (done)->
		request
			.get("#{utils.URL}/item")
			.end (res)->
				res.status.should.equal 200
				res.body.should.be.an.instanceof Array
				res.body.should.have.lengthOf 1
				res.body[0].should.have.property 'title', 'aaa'
				res.body[0].should.have.property 'body', 'bar'
				done()

	it 'should delete item', (done)->
		request
			.del("#{utils.URL}/item/#{itemId}")
			.end (res)->
				res.status.should.equal 204
				request
					.get("#{utils.URL}/item/#{itemId}")
					.end (res)->
						res.status.should.equal 404
						done()