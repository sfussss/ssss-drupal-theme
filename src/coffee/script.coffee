requirejs.config
	paths:
		lib: '../static/lib/'
		bootstrap: '../bootstrap/bootstrap'
		order: '../static/lib/order'

require [ 
	'order!lib/jquery-1.7.2'
	'order!bootstrap'
], ->
	# Hope this works.
	console.log 'This is awesome!'
