Method = require '../Method'

module.exports = class Post extends Method
	defaultMethod: ->'post'
	
	defaultSteps: ->[
		'begin'
		'input'
		'create'
		'save'
		'output'
	]

	input   : (req, res, next)->
		rest = req.rest
		
		rest.fieldValues = req.body
		next null

	create   : (req, res, next)->
		rest = req.rest
		
		self = rest.method

		options = self.options
		
		rest.document = new rest.model
		
		for own field, value of rest.fieldValues
			rest.document[field] = value

		if options.ctimeField
			rest.document[options.ctimeField] = rest.currentTime

		if options.mtimeField
			rest.document[options.mtimeField] = rest.currentTime

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

		res.json rest.document