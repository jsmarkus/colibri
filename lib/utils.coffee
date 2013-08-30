# @see https://gist.github.com/th507/5158907

arrayEqual = (a, b) ->
  i = Math.max(a.length, b.length, 1)
  continue while i-- >= 0 and a[i] is b[i]
  i is -2

exports.flatten = (arr) ->
  r = []
  until arrayEqual(r, arr)
    r = arr
    arr = [].concat.apply([], arr)
  arr
