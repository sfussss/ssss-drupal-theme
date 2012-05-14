requirejs.config
	paths:
		lib: '../ssss/lib/'
		bootstrap: '../bootstrap/bootstrap'
		order: '../ssss/lib/order'

require [ 
	'order!lib/jquery-1.7.2'
	'order!bootstrap'
], ->
	# Hope this works.
	console.log 'This is awesome!'
