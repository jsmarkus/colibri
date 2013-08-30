colibri = require '../'
request = require 'superagent'

utils = require './_utils'

resource = colibri.createResource
    path        : '/004-item'
    model       : utils.ItemModel



resource.use
    list :
        begin : [

            (req, res, next)->
                req.rest.meta.test = 'hello world'
                next null

            (req, res, next)->
                req.rest.meta.test1 = 'hello world1'
                next null

        ]

resource.express utils.app



describe 'Colibri resource with multiple middlewares added as array', ->

    before (done)->
        utils.ItemModel.remove {}, ()->
            docs = [
                { title : 'one',   order : '1'  }
                { title : 'two',   order : '2'  }
                { title : 'three', order : '3'  }
                { title : 'four',  order : '4'  }
            ]
            utils.ItemModel.create docs, done


    it 'should process all middlewares', (done)->
        request
            .get("#{utils.URL}/004-item")
            .end (res)->
                res.body.should.have.property 'test'
                res.body.test.should.equal 'hello world'
                res.body.should.have.property 'test1'
                res.body.test1.should.equal 'hello world1'
                done()
