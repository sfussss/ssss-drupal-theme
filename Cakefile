child_process = require 'child_process'

outputStdout = (data) ->
	console.log data.toString('utf8').trim()

spawnProcess = (name, args) ->
	process = child_process.spawn name, args

	process.stdout.on 'data', outputStdout
	process.stderr.on 'data', outputStdout
	return process

watchLessFiles = ->
	args = [
		'-e'
		"watch( './src/less/.*\\.less' ) { system 'make build-bootstrap-styl' }"
	]

	spawnProcess = spawnProcess 'watchr', args

task 'watch', 'Watch for changes in files.', ->
	watchLessFiles()
