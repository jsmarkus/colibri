# Colibri - MongoDB/Express Scaffolding

Transforms Mongoose scheme to Express REST resource

```CoffeeScript
	Colibri = require 'colibri'

	resource = Colibri.createResource
		#the only mandatory option
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

		#hooks on various steps of each method. See below
		hooks:
			post:
				afterCreateDocument : (req, res, next)->
					req.document.mdate = new Date
					next()

	app.use resource
```

There are two types of requests: list requests (list, post) and item requests (get, put, del).

Each request goes through its own chain of steps. Each step is a standard Express route middleware with `(req, res, next)` arguments.

List:

 * processInput
 * createQuery
 * retrieveList
 * processOutput

Post:

 * processInput
 * createDocument
 * saveDocument
 * processOutput

Put:

 * processInput
 * loadDocument
 * saveDocument
 * processOutput

Get:

 * processInput
 * loadDocument
 * processOutput

Del:

 * processInput
 * loadDocument
 * deleteDocument
 * processOutput

Each step may be hooked from `options.hooks.{method}.{before|after}{StepName}`