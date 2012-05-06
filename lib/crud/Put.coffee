Method = require '../Method'

module.exports = class Put extends Method
	defaultMethod: ->'put'
	
	defaultSteps: ->[
		'begin'
		'input'
		'load'
		'update'
		'save'
		'output'
	]

	input   : (req, res, next)->
		req._id = req.param '_id'
		req.fieldValues = req.body
		next null

	load : (req, res, next)->
		_id = req._id

		req.model.findById _id, (err, doc)->
			if err
				next err
			else
				req.doc = doc
				next null

	update : (req, res, next)->
		for own field, value of req.fieldValues
			console.log field, value
			req.doc[field] = value
		next null

	save : (req, res, next)->
		req.doc.save (err)->
			if err
				next err
			else
				next null

	output  : (req, res, next)->
		unless req.doc
			res.send 404
		else
			res.json req.doc.toObject()