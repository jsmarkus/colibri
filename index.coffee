mongoose = require 'mongoose'

Method = require './lib/Method'

M =
	get  : require './lib/crud/Get'
	put  : require './lib/crud/Put'
	del  : require './lib/crud/Del'
	list : require './lib/crud/List'
	post : require './lib/crud/Post'

_createResource = (app, model, desc, hooks, path, options)->

	defineModel = (req, res, next)->
		req.rest = {}

		req.rest.model = model
		req.rest.currentTime = new Date
		next null

	listPath = path
	itemPath = "#{path}/:_id"

	# "defineModel" middleware
	# Loads model constructor inro req.model
	app.all path,     defineModel
	app.all itemPath, defineModel

	# Routes
	# Performs CRUD operations

	putOptions =
		upsert : options.upsert
		mtimeField : options.mtimeField
		ctimeField : options.ctimeField

	postOptions =
		mtimeField : options.mtimeField
		ctimeField : options.ctimeField

	methods =
		get : new M.get itemPath
		put : new M.put(itemPath, null, null, putOptions)
		del : new M.del itemPath

		post : new M.post(listPath, null, null, postOptions)
		list : new M.list listPath

	for own name, method of methods
		defineSelf = do (method)->
			(req, res, next)->
				req.rest.method = method
				next null

		method.hook begin:defineSelf

		if hooks[name]? then method.hook hooks[name]
		method.addToExpress app

schemaToDescription = (schema)->
	desc = []
	schema.eachPath (name, type)->
		unless name is '_id'
			desc.push name:name, access:'write'
	desc

modelNameToResourcePath = (modelName)->
	'/' + modelName.toLowerCase()

createResource = (app, options)->
	model = options.model
	throw 'No model' unless model

	desc = schemaToDescription model.schema
	path = options.path or modelNameToResourcePath model.modelName

	hooks = options.hooks or {}

	otherOptions =
		upsert : options.upsert
		mtimeField : options.mtimeField
		ctimeField : options.ctimeField

	_createResource app, model, desc, hooks, path, otherOptions


#--------------------------------------------------
exports.createResource = createResource
exports.Method         = Method