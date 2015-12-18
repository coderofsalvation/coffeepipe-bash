#!/usr/bin/env coffee
coffee = require('coffee-script');
data = ''
self = process.stdin
  
getargs = () -> process.argv.slice(2)[0]

readfile = (f) ->
  require("fs").readFileSync(f).toString().replace /\n/gm, " ; "

isArray = (a) -> return Object.prototype.toString.call(a) == "[object Array]";

withPipe = (data) ->
  needfile = ( if getargs().match /\.coffee$/ then true else false )
  data = data.trim()
  data = JSON.parse data if data[0] == "[" or data[1] == "{" and not process.env.NOJSON 
  cmd = ( header = "main = (input) -> ( ") 
  cmd += ( if needfile then readfile(getargs()) else getargs() )
  footer = " )" 
  footer += "(input.data)" if getargs()[0] == "(" or needfile
  cmd += footer
  console.log cmd if process.env.DEBUG
  result = coffee.eval(cmd)({data:data}) 
  return console.log result if typeof result is "string"
  return console.log result.join "\n" if isArray(result)
  return console.log JSON.stringify result

withoutPipe = ->
  result = coffee.eval( getargs() )
  return console.log result if typeof result is "string"
  return console.log result.join "\n" if isArray(result)
  return console.log JSON.stringify result

if process.stdin.isTTY
  withoutPipe()
else
  self.on 'readable', ->
    chunk = @read()
    data += chunk if chunk != null
    return
  self.on 'end', ->
    withPipe data
    return
