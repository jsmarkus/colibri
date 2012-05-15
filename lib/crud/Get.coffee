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
		
		rest._id = req.param '_id'
		next null

	load : (req, res, next)->
		rest = req.rest
		
		_id = rest._id

		rest.model.findById _id, (err, doc)->
			if err
				next err
			else
				rest.document = doc
				next null

	output  : (req, res, next)->
		rest = req.rest

		unless rest.document
			res.send 404
		else
			res.json rest.document.toObject()