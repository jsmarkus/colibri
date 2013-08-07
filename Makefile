NPM_DIR := npm

SRC_PLUGIN := $(shell find plugin -name "*.coffee")
SRC_COFFEE := index.coffee $(shell find lib -name "*.coffee") $(SRC_PLUGIN)
DST_JS := $(patsubst %.coffee,$(NPM_DIR)/%.js,$(SRC_COFFEE))

SRC_EXAMPLE := example
DST_EXAMPLE := $(NPM_DIR)/example

SRC_PACKAGE := package.json
DST_PACKAGE := $(NPM_DIR)/package.json

SRC_README := README.md
DST_README := $(NPM_DIR)/README.md

#----

TESTS := $(wildcard test/*.test.coffee)
MOCHA := node_modules/mocha/bin/mocha
COFFEE := node_modules/mocha/bin/mocha

#----

package: $(DST_JS) $(DST_PACKAGE) $(DST_EXAMPLE) $(DST_README)

clean:
	rm -rfv $(NPM_DIR)

$(DST_EXAMPLE): $(SRC_EXAMPLE)
	cp -r $< $@

$(DST_PACKAGE): $(SRC_PACKAGE)
	cp $< $@

$(DST_README): $(SRC_README)
	cp $< $@

$(NPM_DIR)/%.js : %.coffee
	mkdir -p $(@D) && coffee -o $(@D) -c $<

test:
	$(MOCHA) --compilers coffee:coffee-script --require should $(TESTS)


.PHONY: package docs test