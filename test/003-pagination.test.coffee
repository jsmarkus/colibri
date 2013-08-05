colibri = require '../'
request = require 'superagent'

utils = require './_utils'

pagination = require '../plugin/pagination'

resource = colibri.createResource
	path        : '/paged-item'
	model       : utils.ItemModel

resource.use pagination({itemsPerPage : 4})

resource.express utils.app



describe 'Resource with pagination plugin added', ->

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


	it 'should get a list of items on page2', (done)->
		request
			.get("#{utils.URL}/paged-item?page=2")
			.end (res)->
				res.body.result.should.have.lengthOf 4
				res.body.result[0].title.should.equal 'five'
				res.body.result[3].title.should.equal 'eight'

				res.body.pagination.totalItems.should.equal 10
				res.body.pagination.totalPages.should.equal 3
				res.body.pagination.currentPage.should.equal 2
				done()

	it 'should get a list of items on page1', (done)->
		request
			.get("#{utils.URL}/paged-item")
			.end (res)->
				res.body.result.should.have.lengthOf 4
				res.body.result[0].title.should.equal 'one'
				res.body.result[3].title.should.equal 'four'

				res.body.pagination.totalItems.should.equal 10
				res.body.pagination.totalPages.should.equal 3
				res.body.pagination.currentPage.should.equal 1
				done()

	it 'should get a list of items on page3', (done)->
		request
			.get("#{utils.URL}/paged-item?page=3")
			.end (res)->
				res.body.result.should.have.lengthOf 2
				res.body.result[0].title.should.equal 'nine'
				res.body.result[1].title.should.equal 'ten'

				res.body.pagination.totalItems.should.equal 10
				res.body.pagination.totalPages.should.equal 3
				res.body.pagination.currentPage.should.equal 3
				done()
