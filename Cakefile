child_process = require 'child_process'
watch         = require 'watch'
path          = require 'path'
async         = require 'async'

# TODO: Refactor and rename a bunch of these.

outputStdout = (data) ->
	console.log data.toString('utf8').trim()

spawnProcess = (name, args) ->
	process = child_process.spawn name, args

	process.stdout.on 'data', outputStdout
	process.stderr.on 'data', outputStdout
	return process

spawnLess = -> spawnProcess 'make', [ 'build-bootstrap-sass' ]
spawnSass = -> spawnProcess 'make', [ 'compile-css' ]
spawnCat  = -> spawnProcess 'make', [ 'build-bootstrap-js' ]
spawnCp   = -> spawnProcess 'make', [ 'copy-js' ]

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

watchFiles = (dir, cb) ->
	watch.createMonitor dir, (monitor) ->
		monitor.on 'created', (f, stat) ->
			cb()

		monitor.on 'changed', (f, curr, prev) ->
			if curr.mtime.getTime() isnt prev.mtime.getTime()
				cb()

		monitor.on 'removed', (f, stat) ->
			cb()

watchLessFiles = ->
	watchFiles './src/less', spawnLess

watchSassFiles = ->
	watchFiles './src/sass', spawnSass

watchBootstrapJs = ->
	watchFiles './src/js/bootstrap', spawnCat

watchJs = ->
	watchFiles './src/js/ssss', spawnCp

compileWatchCss = ->
	spawnCat()
	spawnCp()
	watchBootstrapJs()
	watchJs()
	compileCss ->
		watchLessFiles()
		watchSassFiles()

task 'watch', 'Watch for changes in files.', ->
	compileWatchCss()
