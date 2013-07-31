
module.exports = ()->

  list =
    query : (req, res, next)->
      start = req.param 'start', 0
      end = req.param 'end', null

      req.rest.query.skip start

      if end?
        req.rest.query.limit(end - start + 1)

      next null

  return {list}