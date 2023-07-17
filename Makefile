THEME_VERSION := v0.40.1
THEME    := hugo-geekdoc

BASEDIR  := $(CURDIR)
THEMEDIR := $(BASEDIR)/themes
THEMEURL := https://github.com/thegeeklab/$(THEME)/releases/download/${THEME_VERSION}/$(THEME).tar.gz

.PHONY: doc
doc: doc-assets doc-build

.PHONY: doc-assets
doc-assets:
	mkdir -p "$(THEMEDIR)/$(THEME)"
	curl -sSL "$(THEMEURL)" | tar -xz -C "$(THEMEDIR)/$(THEME)/" --strip-components=1

.PHONY: doc-build
doc-build:
	cd "$(BASEDIR)"; hugo --minify

serve: doc-assets
	cd "$(BASEDIR)"; hugo server --buildDrafts --buildFuture --disableFastRender

.PHONY: clean
clean:
	rm -rf "$(THEMEDIR)"
	rm -rf "$(BASEDIR)/public"
