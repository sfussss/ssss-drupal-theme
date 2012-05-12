child_process = require 'child_process'
watch = require 'watch'
path = require 'path'

outputStdout = (data) ->
	console.log data.toString('utf8').trim()

spawnProcess = (name, args) ->
	process = child_process.spawn name, args

	process.stdout.on 'data', outputStdout
	process.stderr.on 'data', outputStdout
	return process

watchLessFiles = ->
	spawnMake = -> spawnProcess 'make', [ 'build-bootstrap-styl' ]

	watch.createMonitor './src/less/', (monitor) ->
		monitor.on 'created', (f, stat) ->
			spawnMake()

		monitor.on 'changed', (f, curr, prev) ->
			if curr.mtime.getTime() isnt prev.mtime.getTime()
				spawnMake()

		monitor.on 'removed', (f, stat) ->
			spawnMake()

task 'watch', 'Watch for changes in files.', ->
	console.log "Watching LESS files for changes."
	watchLessFiles()
