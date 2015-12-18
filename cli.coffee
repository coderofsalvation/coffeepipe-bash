#!/usr/bin/env coffee
coffee = require('coffee-script');
data = ''
self = process.stdin
  
getargs = () -> process.argv.slice(2).join " "

readfile = (f) ->
  require("fs").readFileSync(f).toString().replace /\n/gm, " ; "

withPipe = (data) ->
  data = data.trim()
  data = JSON.parse data if data[0] == "[" or data[1] == "{" and not process.env.NOJSON 
  cmd = ( header = "main = (input) -> ( ") 
  cmd += ( if getargs().match /\.coffee$/ then readfile(getargs()) else getargs() )
  cmd += (footer = " )(input.data)" )
  console.log cmd if process.env.DEBUG
  result = coffee.eval(cmd)({data:data}) 
  console.log ( if typeof result is "string" then result else result.join "\n" )   
  return

withoutPipe = ->
  if args.length 
    console.log "without: "+process.args.join " " 

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
