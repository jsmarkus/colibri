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
		rest = req.rest

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

	remove : (req, res, next)->
		rest = req.rest

		rest.document.remove (err)->
			if err
				next err
			else
				next null

	output  : (req, res, next)->
		res.json null, 204 #No content