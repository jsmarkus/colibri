
module.exports = ()->

  list =
    load : (req, res, next)->
      rest = req.rest
      rest.query.limit(false).skip(false).count (err, count)->
        # console.log 'count', count
        return next err if err
        rest.meta.totalCount = count
        next null


  return {list}