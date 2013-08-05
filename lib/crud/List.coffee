Method = require '../Method'

module.exports = class List extends Method
  defaultVerb: ->'get'

  defaultSteps: ->[
    'begin'
    'input'
    'query'
    'load'
    'serialize'
    'output'
  ]

  input : (req, res, next)->
    next null

  query : (req, res, next)->
    rest = req.rest
    #% list.query ADDS query `rest.model.find()`
    rest.query = rest.model.find()
    next null

  load : (req, res, next)->
    rest = req.rest
    #% list.load USES query to find documents list
    rest.query.exec (err, docs)->
      if err
        next err
      else
        #% list.load ADDS documents result of `req.rest.query.exec()`
        rest.documents = docs
        if docs
          next null
        else
          res.send 404

  serialize : (req, res, next)->
    rest = req.rest
    #% list.serialize ADDS result array of `req.res.documents.toObject()`
    rest.result = (doc.toObject() for doc in rest.documents)
    next null