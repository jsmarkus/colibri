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
	remove : (req, res, next)->
		req.doc.remove (err)->
			if err
				next err
			else
				next null

	output  : (req, res, next)->
		res.json null