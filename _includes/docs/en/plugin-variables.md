`ALL_METHODS.begin` adds `req.rest.meta`:
    origin: 

`ALL_METHODS.begin` adds `req.rest.model`:
    origin: 

`ALL_METHODS.begin` adds `req.rest.currentTime`:
    origin: 

`ALL_METHODS.output` uses `req.rest.result`:
    purpose: to output main result (document or documents list)

`ALL_METHODS.output` uses `req.rest.meta`:
    purpose: to output meta-data (plugin may need to output some variables)

`get.input` adds `req.rest._id`:
    origin: `req.param('_id')`

`get.load` uses `req.rest._id`:
    purpose: to find document

`get.load` adds `req.rest.document`:
    origin: result of `req.rest.model.findById(req.rest._id)`

`get.serialize` adds `req.rest.result`:
    origin: `req.res.document.toObject()`

`del.input` adds `req.rest._id`:
    origin: `req.param('_id')`

`del.load` uses `req.rest._id`:
    purpose: to find document to be deleted

`del.load` adds `req.rest.document`:
    origin: result of `req.rest.model.findById(req.rest._id)`

`del.remove` uses `req.rest.document`:
    purpose: to remove()

`list.query` adds `req.rest.query`:
    origin: `rest.model.find()`

`list.load` uses `req.rest.query`:
    purpose: to find documents list

`list.load` adds `req.rest.documents`:
    origin: result of `req.rest.query.exec()`

`list.serialize` adds `req.rest.result`:
    origin: array of `req.res.documents.toObject()`

`post.input` adds `req.rest.fieldValues`:
    origin: `req.body`

`post.create` adds `req.rest.document`:
    origin: `new req.rest.model` with fields populated from `req.rest.fieldValues`

`post.save` uses `req.rest.document`:
    purpose: to save()

`post.serialize` adds `req.rest.result`:
    origin: `req.res.document.toObject()`

`put.input` adds `req.rest._id`:
    origin: `req.param('_id')`

`put.input` adds `req.rest.fieldValues`:
    origin: `req.body`

`put.load` uses `req.rest._id`:
    purpose: to find document to be updated

`put.load` uses `req.rest.currentTime`:
    purpose: to update field passed in `options.ctimeField`

`put.load` adds `req.rest.document`:
    origin: result of `findById` or newly created (if `upsert` option is on)

`put.update` uses `req.rest.fieldValues`:
    purpose: to populate `req.res.document`

`put.update` uses `req.rest.document`:
    purpose: to populate from `req.res.document`

`put.save` uses `req.rest.document`:
    purpose: to save()

`put.serialize` adds `req.rest.result`:
    origin: `req.res.document.toObject()`

