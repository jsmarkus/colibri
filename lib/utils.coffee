exports.flatten = (arr) ->
  ret = []
  len = arr.length
  i = 0

  while i < len
    if Array.isArray(arr[i])
      exports.flatten arr[i], ret
    else
      ret.push arr[i]
    ++i
  ret