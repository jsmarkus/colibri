# Colibri hooks

Each colibri method is implemented as a stack of Express's route
middleware functions (*steps* in colibri terminology).

Each step performs its small operation. It may be *hooked* by user.
Each hook runs *after* the corresponding step and as well as a step a
hook is also an Express route middleware. So its arguments are
`request`, `response` and `next`.

## options.hooks.get

### begin

Does nothing. Runs in the beginning of the method and is only to be
hooked.

Hooks used to:

 * control user's access to the method

### input

Client request is parsed.

Adds:

 * `req._id` - _id of the document. Used to select the document.

Hooks used to:

 * control user's access to the document basing on document's fields
 * change _id of the document to be selected

### load

The document with `_id = req._id` is loaded.

Adds:

 * `req.doc` - the document

Hooks used to:

 * control user's access to the document basing on document's fields
 * control user's access to specific fields

## options.hooks.put

### begin

Does nothing. Runs in the beginning of the method and is only to be
hooked.

Hooks used to:

 * control user's access to the method

### input

Client's request is parsed.

Adds:

 * `req._id` - _id of the document. Used to select the document before it is updated.
 * `req.fieldValues` - fields from `req.body`. Used to update the document. You may change its values for example to provide default values, validation, or to update any dependent data.

### load

The document with `_id = req._id` is loaded.

Here you may put any logic based on `req.doc` and `rec.fieldValues`
properties.

Adds:

 * `req.doc` - a document loaded from collection butt not yet  updated.

### update

The fields of the document `req.doc` are populated with
`req.fieldValues`. The field specified in `options.mtimeField` is
populated with the current datetime. The document is not yet saved.

### save

The document is saved.

Here you may provide any after-save actions.

## options.hooks.del

### load

The document with `_id = req._id` is loaded.

Adds:

 * `req.doc` - the document

### remove

The document is removed from the collection.

## options.hooks.post

### input
Client's request is parsed.

Adds:

 * `req._id` - _id of the document. Used to select the document before it is updated.
 * `req.fieldValues` - fields from `req.body`. Used to create the document. You may change its values for example to provide default values, validation, or to update any dependent data.

### create

The document is created, but not yet saved.

Here you may change the fields of the document.

Adds:

 * `req.doc` - new document

### save

The document is saved.

Here you may provide any after-save actions. 

## options.hooks.list

### input

Does nothing in current version. In next versions may deal with
sorting/filtering/pagination options.

### query

Adds:

 * `req.query` - Mongoose
[query](http://mongoosejs.com/docs/query.html) object that is used to select a list of documents.

Here you may add any conditions to it to provide custom filtering,
sorting, limitation, access control etc.

### load

Loads the list of the documents using `req.query`.

Here you may change the loaded documents

Adds:

 * `req.docs` - the list of the selected documents
