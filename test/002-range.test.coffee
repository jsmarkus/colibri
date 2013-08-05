colibri = require '../'
request = require 'superagent'

utils = require './_utils'

range = require '../plugin/range'
count = require '../plugin/count'

resource = colibri.createResource
	path        : '/range-item'
	model       : utils.ItemModel

resource.use range()
resource.use count()

resource.express utils.app



describe 'Colibri resource with range and count plugins added', ->

	before (done)->
		utils.ItemModel.remove {}, ()->
			docs = [
				{ title : 'one',   order : '1'  }
				{ title : 'two',   order : '2'  }
				{ title : 'three', order : '3'  }
				{ title : 'four',  order : '4'  }
				{ title : 'five',  order : '5'  }
				{ title : 'six',   order : '6'  }
				{ title : 'seven', order : '7'  }
				{ title : 'eight', order : '8'  }
				{ title : 'nine',  order : '9'  }
				{ title : 'ten',   order : '10' }
			]
			utils.ItemModel.create docs, done


	it 'should get a list of items', (done)->
		request
			.get("#{utils.URL}/range-item")
			.end (res)->
				res.status.should.equal 200
				res.body.result.should.be.an.instanceof Array
				res.body.result.should.have.lengthOf 10
				res.body.result[0].should.have.property 'title', 'one'
				res.body.totalCount.should.equal 10
				done()

	it 'should get a list of items', (done)->
		request
			.get("#{utils.URL}/range-item?start=2&end=5")
			.end (res)->
				res.body.result.should.have.lengthOf 4
				res.body.result[0].title.should.equal 'three'
				res.body.result[3].title.should.equal 'six'
				res.body.totalCount.should.equal 10
				done()
