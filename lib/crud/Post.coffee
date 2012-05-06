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
		req.fieldValues = req.body
		next null

	create   : (req, res, next)->
		req.doc = new req.model req.fieldValues		
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
			res.json req.doc