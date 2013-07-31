module.exports = class Method
  constructor : (@model, path=null, @options={}, verb, steps)->
    @verb = if verb? then verb else @defaultVerb()

    unless @verb in ['all', 'get', 'post', 'put', 'del']
      throw new Error "Undefined verb '#{@verb}'"

    @path = if path? then path else @defaultPath()
    @steps = if steps? then steps else @defaultSteps()

    @routes = {}
    @autoAdd()

  defaultSteps  : ()-> []
  defaultVerb : ()-> 'all'
  defaultPath   : ()-> '/'


  routesByStep : (step)->
    if @routes[step]
      return @routes[step]
    []

  autoAdd : ()->
    for step in @steps
      if toString.call(@[step]) == '[object Function]'
        @add step, @[step]

  use : (hooks)->
    for own step, middleware of hooks
      @add step, middleware

  add : (step, middleware)->
    unless @routes[step]
      @routes[step] = []
    @routes[step].push middleware

  getVerb : ->
    return @verb

  getPath : ->
    return @path

  getMiddleware : ->
    return (@routesByStep step for step in @steps)

  begin : (req, res, next)=>
    req.rest = {}

    req.rest.model = @model
    req.rest.currentTime = new Date
    next null
