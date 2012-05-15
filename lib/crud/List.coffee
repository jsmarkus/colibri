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
		rest.query = rest.model.find()
		next null

	load : (req, res, next)->
		rest = req.rest
		rest.query.exec (err, docs)->
			if err
				next err
			else
				rest.documents = docs
				next null

	output  : (req, res, next)->
		rest = req.rest
		
		unless rest.documents
			res.send 404
		else
			res.json (doc.toObject() for doc in rest.documents)