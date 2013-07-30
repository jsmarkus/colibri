Method = require '../Method'

module.exports = class Get extends Method
  defaultMethod: ->'get'

  defaultSteps: ->[
    'begin'
    'input'
    'load'
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
        next null

  output  : (req, res, next)->
    rest = req.rest

    #% get.output USES document to be outputed
    unless rest.document
      res.send 404
    else
      res.json rest.document.toObject()