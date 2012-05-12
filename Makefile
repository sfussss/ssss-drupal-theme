BOOTSTRAP_LESS = ./less/bootstrap.less
BOOTSTRAP_RESPONSIVE_LESS = ./less/responsive.less

TO_STYL=./src/styl/bin
BOOTSTRAP_STYL=${TO_STYL}/bootstrap

JS_BOOTSTRAP=./src/js/bootstrap

JS_BIN=./src/js/bin
JS_BOOTSTRAP_CONCAT=${JS_BIN}/bootstrap

#
# RUN JSHINT & QUNIT TESTS IN PHANTOMJS
#

test:
	jshint js/*.js --config js/.jshintrc
	jshint js/tests/unit/*.js --config js/.jshintrc
	node js/tests/server.js &
	phantomjs js/tests/phantom.js "http://localhost:3000/js/tests"
	kill -9 `cat js/tests/pid.txt`
	rm js/tests/pid.txt

#bootstrap:
	#mkdir -p bootstrap/img
	#cp img/* bootstrap/img/
	#cat js/bootstrap-transition.js js/bootstrap-alert.js js/bootstrap-button.js js/bootstrap-carousel.js js/bootstrap-collapse.js js/bootstrap-dropdown.js js/bootstrap-modal.js js/bootstrap-tooltip.js js/bootstrap-popover.js js/bootstrap-scrollspy.js js/bootstrap-tab.js js/bootstrap-typeahead.js > bootstrap/js/bootstrap.js
	#uglifyjs -nc bootstrap/js/bootstrap.js > bootstrap/js/bootstrap.min.tmp.js
	#echo "/*!\n* Bootstrap.js by @fat & @mdo\n* Copyright 2012 Twitter, Inc.\n* http://www.apache.org/licenses/LICENSE-2.0.txt\n*/" > bootstrap/js/copyright.js
	#cat bootstrap/js/copyright.js bootstrap/js/bootstrap.min.tmp.js > bootstrap/js/bootstrap.min.js
	#rm bootstrap/js/copyright.js bootstrap/js/bootstrap.min.tmp.js

build-js:
	mkdir -p ${JS_BOOTSTRAP_CONCAT}
	cat ${JS_BOOTSTRAP}/bootstrap-transition.js ${JS_BOOTSTRAP}/bootstrap-alert.js ${JS_BOOTSTRAP}/bootstrap-button.js ${JS_BOOTSTRAP}/bootstrap-carousel.js ${JS_BOOTSTRAP}/bootstrap-collapse.js ${JS_BOOTSTRAP}/bootstrap-dropdown.js ${JS_BOOTSTRAP}/bootstrap-modal.js ${JS_BOOTSTRAP}/bootstrap-tooltip.js ${JS_BOOTSTRAP}/bootstrap-popover.js ${JS_BOOTSTRAP}/bootstrap-scrollspy.js ${JS_BOOTSTRAP}/bootstrap-tab.js ${JS_BOOTSTRAP}/bootstrap-typeahead.js > ${JS_BOOTSTRAP_CONCAT}/bootstrap.js

copy-images:
	mkdir -p bin/bootstrap/img
	cp img/* bootstrap/img/

build-bootstrap:
	mkdir -p ${BOOTSTRAP_STYL}
	recess --compile ${BOOTSTRAP_LESS} > ${BOOTSTRAP_STYL}/bootstrap.styl
	recess --compile ${BOOTSTRAP_RESPONSIVE_LESS} > ${BOOTSTRAP_STYL}/bootstrap-responsive.styl

clean:
	rm -rf ${TO_STYL}
	rm -rf bin
	rm -rf node_modules
