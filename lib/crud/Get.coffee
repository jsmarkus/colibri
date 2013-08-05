Method = require '../Method'

module.exports = class Get extends Method
  defaultVerb: ->'get'

  defaultSteps: ->[
    'begin'
    'input'
    'load'
    'load'
    'serialize'
    'output'
  ]

  input   : (req, res, next)->
    rest =req.rest

    #% get.input ADDS _id `req.param('_id')`
    rest._id = req.param '_id'
    next null

  load : (req, res, next)->
    rest = req.rest

    #% get.load USES _id to find document
    _id = rest._id

    rest.model.findById _id, (err, doc)->
      if err
        next err
      else
        #% get.load ADDS document result of `req.rest.model.findById(req.rest._id)`
        rest.document = doc
        if doc
          next null
        else
          res.send 404

  serialize : (req, res, next)->
    rest = req.rest
    #% get.serialize ADDS result `req.res.document.toObject()`
    rest.result = rest.document.toObject()
    next null