Method = require '../Method'

module.exports = class Put extends Method
	defaultMethod: ->'put'
	
	defaultSteps: -> [
		'begin'
		'input'
		'load'
		'update'
		'save'
		'output'
	]

	input : (req, res, next)->
		rest             = req.rest
		rest._id         = req.param '_id'
		rest.fieldValues = req.body
		next null

	load : (req, res, next)->
		rest = req.rest
		_id  = rest._id
		self = rest.method

		rest.model.findById _id, (err, doc)->
			if err
				next err
			else
				#not found: create if 'upsert' option is on, 404 otherwise
				unless doc
					if self.options.upsert
						doc = new rest.model
						if self.options.ctimeField
							doc[self.options.ctimeField] = rest.currentTime
					else
						res.send 404
						return

				rest.document = doc
				next null

	update : (req, res, next)->
		rest = req.rest
		self = rest.method

		for own field, value of rest.fieldValues
			rest.document[field] = value

		if self.options.mtimeField
			rest.document[self.options.mtimeField] = rest.currentTime

		next null

	save : (req, res, next)->
		rest = req.rest

		rest.document.save (err)->
			if err
				next err
			else
				next null

	output  : (req, res, next)->
		rest = req.rest

		unless rest.document
			res.send 404
		else
			res.json rest.document.toObject()