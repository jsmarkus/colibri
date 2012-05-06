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
		req._id = req.param '_id'
		next null

	load : (req, res, next)->
		_id = req._id

		req.model.findById _id, (err, doc)->
			if err
				next err
			else
				req.doc = doc
				next null

	output  : (req, res, next)->
		unless req.doc
			res.send 404
		else
			res.json req.doc.toObject()