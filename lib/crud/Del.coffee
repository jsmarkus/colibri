Method = require '../Method'

module.exports = class Del extends Method
  defaultVerb  : ->'del'
  successCode  : -> 204

  defaultSteps: ->[
    'begin'
    'input'
    'load'
    'remove'
    'output'
  ]

  input : (req, res, next)->
    rest = req.rest

    #% del.input ADDS _id `req.param('_id')`
    rest._id = req.param '_id'
    next null

  load : (req, res, next)->
    rest = req.rest

    #% del.load USES _id to find document to be deleted
    _id = rest._id

    rest.model.findById _id, (err, doc)->
      if err
        next err
      else
        #% del.load ADDS document result of `req.rest.model.findById(req.rest._id)`
        rest.document = doc
        next null

  remove : (req, res, next)->
    rest = req.rest

    #% del.remove USES document to remove()
    rest.document.remove (err)->
      if err
        next err
      else
        next null
