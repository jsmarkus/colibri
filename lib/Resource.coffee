module.exports = class Resource

  constructor: () ->
    @methods = {}

  addMethod: (name, method)->
    @methods[name] = method

  hasMethod: (name)->
    return yes if @methods.hasOwnProperty name
    return no

  use: (plugin)->
    for own methodName, hooks of plugin
      unless @hasMethod methodName
        throw new Error "Cannot add plugin. No method #{methodName}"
      @methods[methodName].use hooks

  express: (app)->
    for own name, method of @methods
      app[method.getVerb()] method.getPath(), method.getMiddleware()
