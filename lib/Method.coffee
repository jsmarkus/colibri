module.exports = class Method
  constructor : (path=null, method=null, steps=null, @options={})->
    @method = if method? then method else @defaultMethod()

    unless @method in ['all', 'get', 'post', 'put', 'del']
      throw new Error "Undefined method '#{@method}'"

    @path = if path? then path else @defaultPath()
    @steps = if steps? then steps else @defaultSteps()

    @routes = {}
    @autoAdd()

  defaultSteps  : ()-> []
  defaultMethod : ()-> 'all'
  defaultPath   : ()-> '/'


  routesByStep : (step)->
    if @routes[step]
      return @routes[step]
    []

  autoAdd : ()->
    for step in @steps
      if toString.call(@[step]) == '[object Function]'
        @add step, @[step]

  hook : (hooks)->
    for own step, callbackFuntion of hooks
      @add step, callbackFuntion

  add : (step, callbackFunction)->
    unless @routes[step]
      @routes[step] = []
    @routes[step].push callbackFunction

  addToExpress: (app)->
    for step in @steps
      routes = @routesByStep step
      app[@method] @path, routes
