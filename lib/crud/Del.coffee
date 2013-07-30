Method = require '../Method'

module.exports = class Del extends Method
  defaultMethod: ->'del'

  defaultSteps: ->[
    'begin'
    'input'
    'load'
    'remove'
    'output'
  ]

  input : (req, res, next)->
    rest = req.rest

    #% del.input ADDS _id parsed from request
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
        #% del.load ADDS document to be removed
        rest.document = doc
        next null

  remove : (req, res, next)->
    rest = req.rest

    #% del.remove USES document to call remove() method against
    rest.document.remove (err)->
      if err
        next err
      else
        next null

  output : (req, res, next)->
    res.json null, 204 #No content