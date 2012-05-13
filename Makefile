SRC=./src
BIN=./bin

BOOTSTRAP_LESS=${SRC}/less/bootstrap.less
BOOTSTRAP_RESPONSIVE_LESS=${SRC}/less/responsive.less

TO_SASS=${SRC}/sass/bin
BOOTSTRAP_SASS=${TO_SASS}/bootstrap

JS_SRC=${SRC}/js

JS_BOOTSTRAP=${JS_SRC}/bootstrap

JS_BIN=${BIN}/js
JS_BOOTSTRAP_CONCAT=${JS_BIN}/bootstrap

test:
	jshint js/*.js --config js/.jshintrc
	jshint js/tests/unit/*.js --config js/.jshintrc
	node js/tests/server.js &
	phantomjs js/tests/phantom.js "http://localhost:3000/js/tests"
	kill -9 `cat js/tests/pid.txt`
	rm js/tests/pid.txt

build-bootstrap-js:
	@mkdir -p ${JS_BOOTSTRAP_CONCAT}
	@cat ${JS_BOOTSTRAP}/bootstrap-transition.js ${JS_BOOTSTRAP}/bootstrap-alert.js ${JS_BOOTSTRAP}/bootstrap-button.js ${JS_BOOTSTRAP}/bootstrap-carousel.js ${JS_BOOTSTRAP}/bootstrap-collapse.js ${JS_BOOTSTRAP}/bootstrap-dropdown.js ${JS_BOOTSTRAP}/bootstrap-modal.js ${JS_BOOTSTRAP}/bootstrap-tooltip.js ${JS_BOOTSTRAP}/bootstrap-popover.js ${JS_BOOTSTRAP}/bootstrap-scrollspy.js ${JS_BOOTSTRAP}/bootstrap-tab.js ${JS_BOOTSTRAP}/bootstrap-typeahead.js > ${JS_BOOTSTRAP_CONCAT}/bootstrap.js

	@echo "Bootstrap is now compiled."

build-js:
	@make build-bootstrap-js
	@cp -rf ${JS_SRC}/ssss ${JS_BIN}/ssss

copy-images:
	mkdir -p bin/bootstrap/img
	cp img/* bootstrap/img/

build-bootstrap-sass:
	@mkdir -p ${BOOTSTRAP_SASS}
	@recess --compile ${BOOTSTRAP_LESS} > ${BOOTSTRAP_SASS}/_bootstrap.scss
	@recess --compile ${BOOTSTRAP_RESPONSIVE_LESS} > ${BOOTSTRAP_SASS}/_bootstrap-responsive.scss
	@echo "Bootstrap styles built."

compile-css:
	@sass -f --update src/sass:bin/css
	@echo "Sass files have compiled."

clean:
	rm -rf ${TO_SASS}
	rm -rf bin
	rm -rf .sass-cache

clean-all:
	make clean
	rm -rf node_modules
