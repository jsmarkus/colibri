# Colibri API

## colibri.createResource(app, options)

Creates RESTful resource and makes Express `app` serve it.

## options.model

Mongoose model.

See Mongoose [Models/Schemas](http://mongoosejs.com/docs/model-definition.html)
for examples of model definition.

## options.hooks

Hook functions.

Hooks make colibri framework flexible and customizable.

With no hooks it works by default - just publishes mongodb collection as RESTful resource.

With hooks you can customize its behaviour by intercepting any colibri method in its any step.

Hooks may be used for:

 * *access control*. You may prevent the user from accessing any methods, any documents or any fields.
 * *query customization*. You may customize `list` method to add server-side sorting, filtering, limitation.
 * *logging*. You may log data changes or update the related data - counters, history collections, etc.
 * *output formating*. You may change output format.
 * *any other businesss logic*. See [hooks](./hooks.html).

## options.mtimeField

A name of model field that is used to store a document modification time.

Omit this option if you don't want to store modification time.

## options.ctimeField

A name of model field that is used to store a document creation time.

Omit this option if you don't want to store creation time.

## options.allowUpsert

Whether to allow creation of an object with `put` method.

By default `put` method only updates existing document or answers 404 if the document does no exist.
Specifying `allowUpsert = true` in options you can change this behavior.