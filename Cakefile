child_process = require 'child_process'
watch         = require 'watch'
path          = require 'path'
async         = require 'async'
fs            = require 'fs'

# TODO: Refactor and rename a bunch of these.

outputStdout = (data) ->
  console.log data.toString('utf8').trim()

spawnProcess = (name, args) ->
  process = child_process.spawn name, args

  process.stdout.on 'data', outputStdout
  process.stderr.on 'data', outputStdout
  return process

spawnLess  = -> spawnProcess 'make', [ 'build-bootstrap-sass' ]
spawnSass  = -> spawnProcess 'make', [ 'compile-sass' ]
spawnCat   = -> spawnProcess 'make', [ 'build-bootstrap-js' ]
spawnCpJs  = -> spawnProcess 'make', [ 'copy-js' ]
spawnCpImg = -> spawnProcess 'make', [ 'copy-images' ]

compileCss = (cb) ->
  async.waterfall [
    (callback) ->
      less = spawnLess()

      less.on 'exit', (code, signal) ->
        callback null, code, signal

    (code, signal, callback) ->
      if not code?
        throw new Error "Bootstrap failed to build."

      sass = spawnSass()

      sass.on 'exit', (code, signal) ->
        callback null, code, signal

    (code, signal, callback) ->
      if not code?
        throw new Error "None of the styles managed to be built."

      if typeof cb is 'function'
        cb()
  ]

compileInfoFile = ->
	try
  	jsonInfo = JSON.parse(fs.readFileSync 'ssss.info.json', 'utf8')
  	packageInfo = JSON.parse(fs.readFileSync 'package.json', 'utf8')
  catch e
  	console.log e
  	return

  infoFile = "version = #{packageInfo.version}\n"

  for k, v of jsonInfo
    infoFile += "#{k} = #{v}\n"

  fs.writeFileSync 'ssss.info', infoFile, 'utf8'

  console.log 'The info file has compiled successfully.'

watchFiles = (dir, cb) ->
  watch.createMonitor dir, (monitor) ->
    monitor.on 'created', (f, stat) ->
      cb()

    monitor.on 'changed', (f, curr, prev) ->
      if curr.mtime.getTime() isnt prev.mtime.getTime()
        cb()

    monitor.on 'removed', (f, stat) ->
      cb()

watchSingleFile = (path, callback) ->
	fs.watchFile path, (curr, prev) ->
		if curr.mtime.getTime() > prev.mtime.getTime()
    	callback()

watchLessFiles = ->
  watchFiles './src/less', spawnLess

watchSassFiles = ->
  watchFiles './src/sass', spawnSass

watchBootstrapJs = ->
  watchFiles './src/js/bootstrap', spawnCat

watchJs = ->
  watchFiles './src/js/static', spawnCpJs

watchImg = ->
  watchFiles './src/img', spawnCpImg

watchCoffee = ->
  coffeeArgs = [
    '--watch'
    '--output'
    './bin/js/coffee_build/'
    './src/coffee/'
  ]
  spawnProcess 'coffee', coffeeArgs

watchInfo = ->
  compileInfoFile()

  watchSingleFile 'ssss.info.json', ->
  	compileInfoFile()

  watchSingleFile 'package.json', ->
  	compileInfoFile()

compileWatchCss = ->
  spawnCpImg()
  spawnCat()
  spawnCpJs()
  watchBootstrapJs()
  watchJs()
  watchImg()
  watchCoffee()
  watchInfo()
  compileCss ->
    watchLessFiles()
    watchSassFiles()

task 'watch', 'Watch for changes in files.', ->
  compileWatchCss()

task 'compile-info-file', 'Compile the .info file.', ->
  compileInfoFile()
