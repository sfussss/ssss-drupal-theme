requirejs.config
	paths:
		lib: '../ssss/lib/'
		bootstrap: '../bootstrap/bootstrap'

require [ 
	'lib/require/order!lib/jquery-1.7.2'
	'lib/require/order!bootstrap'
], ->
	# Hope this works.
	console.log 'This is awesome!'
