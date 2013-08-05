

module.exports = (options)->
  options = options or {}
  ITEMS_PER_PAGE = options.itemsPerPage or 10
  PAGE_PARAM = options.pageParameterName or 'page'


  list =
    begin: (req, res, next)->
      rest = req.rest
      rest.pagination = {}
      next null

    query : (req, res, next)->
      {query, pagination} = req.rest

      page = parseInt(req.param PAGE_PARAM) or 1
      page = 1 if page <= 0

      skip = ITEMS_PER_PAGE * (page - 1)
      limit = ITEMS_PER_PAGE

      query.skip skip
      query.limit limit

      next null

    load : (req, res, next)->
      {query, pagination} = req.rest

      query.limit(false).skip(false).count (err, count)->
        return next err if err
        pagination.totalItems = count
        pagination.totalPages = Math.ceil(count / ITEMS_PER_PAGE)
        next null


  return {list}