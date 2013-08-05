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
    #% put.input ADDS _id `req.param('_id')`
    rest._id         = req.param '_id'
    #% put.input ADDS fieldValues `req.body`
    rest.fieldValues = req.body
    next null

  load : (req, res, next)->
    rest = req.rest

    #% put.load USES _id to find document to be updated
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
              #% put.load USES currentTime to update field passed in `options.ctimeField`
              doc[@options.ctimeField] = rest.currentTime
          else
            res.send 404
            return

        #% put.load ADDS document result of `findById` or newly created (if `upsert` option is on)
        rest.document = doc
        next null

  update : (req, res, next)->
    rest = req.rest

    #% put.update USES fieldValues to populate `req.res.document`
    for own field, value of rest.fieldValues #TODO: write doclet
      #% put.update USES document to populate from `req.res.document`
      rest.document[field] = value

    if @options.mtimeField
      rest.document[@options.mtimeField] = rest.currentTime

    next null

  save : (req, res, next)->
    rest = req.rest

    #% put.save USES document to save()
    rest.document.save (err)->
      if err
        next err
      else
        next null

  serialize : (req, res, next)->
    rest = req.rest
    #% put.serialize ADDS result `req.res.document.toObject()`
    rest.result = rest.document.toObject()
    next null