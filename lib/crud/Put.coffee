Method = require '../Method'

module.exports = class Put extends Method
  defaultVerb: ->'put'

  defaultSteps: -> [
    'begin'
    'input'
    'load'
    'update'
    'save'
    'serialize'
    'output'
  ]

  input : (req, res, next)->
    rest             = req.rest
    rest._id         = req.param '_id'
    rest.fieldValues = req.body
    next null

  load : (req, res, next)=>
    rest = req.rest
    _id  = rest._id

    rest.model.findById _id, (err, doc)=>
      if err
        next err
      else
        #not found: create if 'upsert' option is on, 404 otherwise
        unless doc
          if @options.upsert
            doc = new rest.model
            doc._id = _id #we have to populate _id from HTTP query, because to upsert in PUT means to create a document with known _id
            if @options.ctimeField
              doc[@options.ctimeField] = rest.currentTime
          else
            res.send 404
            return

        rest.document = doc
        next null

  update : (req, res, next)=>
    rest = req.rest
    self = rest.method

    for own field, value of rest.fieldValues
      rest.document[field] = value

    if @options.mtimeField
      rest.document[@options.mtimeField] = rest.currentTime

    next null

  save : (req, res, next)->
    rest = req.rest

    rest.document.save (err)->
      if err
        next err
      else
        next null

  serialize : (req, res, next)->
    rest = req.rest
    rest.result = rest.document.toObject()
    next null