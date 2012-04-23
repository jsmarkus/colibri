== Colibri - MongoDB/Express Scaffolding

Transforms Mongoose scheme to Express REST resource

	Mango = require 'express-mango'

	resource = Mango.createResource
		#only mandatory option
		schema : MySchema

		#redefining fields. default is all/write
		fields : [
			{
				name   : 'foo'
				access : 'read'
			}
			{
				name   : 'bar'
				access : 'write'
			}
		]

		#or: dynamically redefine fields - function that `next`s description array
		fields : (req, res, next)->

		#similar to `fields` - defines access to fields in `list` method
		listFields

		#create hook
		post : (req, res, next)->
			#do something with req.model
		
		#update hook
		put : (req, res, next)->
			#do something with req.model

		#remove hook
		del : (req, res, next)->
			#do something with req.model

		#retrieve hook
		get : (req, res, next)->
			#do something with res.model

		list : (req, res, next)->
			#do something with res.collection		

	app.use resource

