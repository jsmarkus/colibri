Method = require '../Method'

module.exports = class List extends Method
  defaultMethod: ->'get'

  defaultSteps: ->[
    'begin'
    'input'
    'query'
    'load'
    'output'
  ]

  input : (req, res, next)->
    next null

  query : (req, res, next)->
    rest = req.rest
    #% list.query ADDS query to find documents list
    rest.query = rest.model.find()
    next null

  load : (req, res, next)->
    rest = req.rest
    #% list.load USES query to find documents list
    rest.query.exec (err, docs)->
      if err
        next err
      else
        #% list.load ADDS documents
        rest.documents = docs
        next null

  output  : (req, res, next)->
    rest = req.rest

    #% list.output USES documents to be outputed
    unless rest.documents
      res.send 404
    else
      res.json (doc.toObject() for doc in rest.documents)