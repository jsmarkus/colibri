Method = require '../Method'

module.exports = class Post extends Method
  defaultVerb: ->'post'

  defaultSteps: ->[
    'begin'
    'input'
    'create'
    'save'
    'serialize'
    'output'
  ]

  input   : (req, res, next)->
    rest = req.rest

    #% post.input ADDS fieldValues parsed from request body
    rest.fieldValues = req.body
    next null

  create   : (req, res, next)->
    rest = req.rest

    options = @options

    #% post.create ADDS document with fields populated from fieldValues
    rest.document = new rest.model

    for own field, value of rest.fieldValues
      rest.document[field] = value

    if options.ctimeField
      rest.document[options.ctimeField] = rest.currentTime

    if options.mtimeField
      rest.document[options.mtimeField] = rest.currentTime

    next null

  save : (req, res, next)->
    rest = req.rest

    #% post.save USES document to call save() against
    rest.document.save (err)->
      if err
        next err
      else
        next null

  serialize : (req, res, next)->
    rest = req.rest
    rest.result = rest.document.toObject()
    next null