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

	input   : (req, res, next)->
		next null

	query   : (req, res, next)->
		req.query = req.model.find()
		next null

	load : (req, res, next)->
		req.query.exec (err, docs)->
			if err
				next err
			else
				req.docs = docs
				next null

	output  : (req, res, next)->
		unless req.docs
			res.send 404
		else
			res.json (doc.toObject() for doc in req.docs)