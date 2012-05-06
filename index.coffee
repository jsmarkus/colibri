mongoose = require 'mongoose'

Method = require './lib/Method'

itemMethods =
	get  : require './lib/crud/Get'
	put  : require './lib/crud/Put'
	del  : require './lib/crud/Del'

listMethods =
	list : require './lib/crud/List'
	post : require './lib/crud/Post'

_createResource = (app, model, desc, hooks, path)->

	defineModel = (req, res, next)->
		req.model = model
		next null

	listPath = path
	itemPath = "#{path}/:_id"
	
	# "defineModel" middleware
	# Loads model constructor inro req.model
	app.all path,     defineModel
	app.all itemPath, defineModel

	# Routes
	# Performs CRUD operations

	for own name, klass of itemMethods
		methodInstance = new klass itemPath
		if hooks[name]? then methodInstance.hook hooks[name]
		methodInstance.addToExpress app

	for own name, klass of listMethods
		methodInstance = new klass listPath
		if hooks[name]? then methodInstance.hook hooks[name]
		methodInstance.addToExpress app

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
	path = modelNameToResourcePath model.modelName

	hooks = options.hooks or {}

	_createResource app, model, desc, hooks, path


#--------------------------------------------------
exports.createResource = createResource
exports.Method = Method 