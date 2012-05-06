NPM_DIR := npm

SRC_COFFEE := index.coffee $(shell find lib -name "*.coffee")
DST_JS := $(patsubst %.coffee,$(NPM_DIR)/%.js,$(SRC_COFFEE))

SRC_EXAMPLE = example
DST_EXAMPLE = $(NPM_DIR)/example

SRC_PACKAGE = package.json
DST_PACKAGE = $(NPM_DIR)/package.json

package: $(DST_JS) $(DST_PACKAGE) $(DST_EXAMPLE)

clean:
	rm -rfv $(NPM_DIR)

$(DST_EXAMPLE): $(SRC_EXAMPLE)
	cp -r $< $@ 

$(DST_PACKAGE): $(SRC_PACKAGE)
	cp $< $@

$(NPM_DIR)/%.js : %.coffee
	mkdir -p $(@D) && coffee -o $(@D) -c $<
