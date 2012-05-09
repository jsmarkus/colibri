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

	input   : (req, res, next)=>
		req._id = req.param '_id'
		req.fieldValues = req.body
		next null

	load : (req, res, next)=>
		_id = req._id

		req.model.findById _id, (err, doc)->
			if err
				next err
			else
				#not found: create if 'upsert' option is on, 404 otherwise
				unless doc
					if @options.upsert
						doc = new req.model
						if @options.ctimeField
							req.doc[@options.ctimeField] = req.currentTime
					else
						res.send 404
						return

				req.doc = doc
				next null

	update : (req, res, next)=>
		for own field, value of req.fieldValues
			req.doc[field] = value

		if @options.mtimeField
			req.doc[@options.mtimeField] = req.currentTime

		next null

	save : (req, res, next)=>
		req.doc.save (err)->
			if err
				next err
			else
				next null

	output  : (req, res, next)=>
		unless req.doc
			res.send 404
		else
			res.json req.doc.toObject()