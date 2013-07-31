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

    #% get.input ADDS _id parsed from request
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
        #% get.load ADDS document found from DB
        rest.document = doc
        if doc
          next null
        else
          res.send 404

  serialize : (req, res, next)->
    rest = req.rest
    rest.result = rest.document.toObject()
    next null