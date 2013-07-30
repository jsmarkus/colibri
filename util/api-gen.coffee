#!/usr/bin/env coffee

fs = require 'fs'

files = [
  'Get.coffee'
  'Del.coffee'
  'List.coffee'
  'Post.coffee'
  'Put.coffee'
]

main = ->
  process.chdir "#{__dirname}/../lib/crud"
  for file in files
    text = fs.readFileSync file, 'utf8'
    parse text

parse = (text)->
  lines = text.split '\n'
  for line, lineNum in lines
    row = parseLine line, lineNum+1
    continue unless row
    console.log formatRow row

parseLine = (line, ln)->
  m = line.match /#%\s*(\w+)\.(\w+)\s*(ADDS|USES)\s*(\w+)\s*(.*)$/
  if m
    row =
      lineNumber : ln
      httpMethod : m[1]
      step       : m[2]
      operation  : m[3]
      variable   : m[4]
      comments   : m[5]
    return row
  return false

formatRow = (r)->
  "`#{r.httpMethod}.#{r.step}` #{r.operation} `req.rest.#{r.variable}` #{r.comments}"


do main
