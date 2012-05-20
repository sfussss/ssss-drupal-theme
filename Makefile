SRC=./src
BIN=./bin

BOOTSTRAP_LESS=${SRC}/less/bootstrap.less
BOOTSTRAP_RESPONSIVE_LESS=${SRC}/less/responsive.less

TO_SASS=${SRC}/sass/bin
BOOTSTRAP_SASS=${TO_SASS}/bootstrap

JS_SRC=${SRC}/js
COFFEE_SRC=${SRC}/coffee

JS_BOOTSTRAP=${JS_SRC}/bootstrap

JS_BIN=${BIN}/js
JS_BOOTSTRAP_CONCAT=${JS_BIN}/bootstrap

COFFEE_BUILD=${JS_BIN}/coffee_build

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

copy-js:
	@mkdir -p ${JS_BIN}/static
	@cp -rf ${JS_SRC}/static ${JS_BIN}
	@echo "The JavaScript code has been copied."

build-coffee:
	@mkdir -p ${COFFEE_BUILD}
	@coffee --compile --output ${COFFEE_BUILD}/ ${COFFEE_SRC}/

# Use this to build the entire project.

build-js:
	@make build-bootstrap-js
	@make copy-js
	@make build-coffee
	@echo "JavaScript is built."

copy-images:
	@mkdir -p bin/img
	@cp src/img/* bin/img/
	@echo "The images have been copied."

build-bootstrap-sass:
	@mkdir -p ${BOOTSTRAP_SASS}
	@recess --compile ${BOOTSTRAP_LESS} > ${BOOTSTRAP_SASS}/_bootstrap.scss
	@recess --compile ${BOOTSTRAP_RESPONSIVE_LESS} > ${BOOTSTRAP_SASS}/_bootstrap-responsive.scss
	@echo "Bootstrap styles built."

compile-sass:
	@sass -f --update src/sass:bin/css
	@echo "Sass files have compiled."

build-css:
	@make build-bootstrap-sass
	@make compile-sass
	@echo "CSS has been compiled."

compress-css:
	@# Better safe than sorry. Build the CSS code...
	@make build-css

	@# .. THEN compress it.
	@recess ./bin/css/style.css --compress > ./bin/css/style.min.css
	
	@rm ./bin/css/style.css
	@cp ./bin/css/style.min.css ./bin/css/style.css
	@rm ./bin/css/style.min.css

compress-js:
	@# Better safe than sorry. Build the JavaScript code...
	@make build-js

	@# ...THEN compress it.
	@node r.js -o app.build.js #name=bin/js/coffee_build/script out=bin.tmp/script.js baseUrl=.

	@rm -rf bin/js
	@mkdir -p bin/js/coffee_build
	@cp bin.tmp/* bin/js/coffee_build
	@rm -rf bin.tmp
	@mkdir -p bin/js/static/lib
	@cp src/js/static/lib/require.js bin/js/static/lib/require.js

	@uglifyjs -o bin/js/static/lib/require.js bin/js/static/lib/require.js

build-project:
	@make copy-images
	@make build-css
	@make build-js
	@cake compile-info-file

build-project-compressed:
	@make build-project
	@make compress-js
	@make compress-css

distribute:
	@make build-project-compressed

	@rm -rf dist

	@mkdir dist

	@cp -r bin dist/bin
	@cp -r templates dist/templates
	@cp ssss.info dist/ssss.info

clean:
	rm -rf ${TO_SASS}
	rm -rf bin
	rm -rf .sass-cache
	rm -rf bin.tmp
	rm -rf dist
	rm -f ssss.info

clean-all:
	make clean
	rm -rf node_modules
