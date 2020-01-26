.SUFFIXES:

.PHONY: all check clean dist distclean doc release
all: doc

include install.mk

ASCIIDOC ?= asciidoctor
DIST_VERSION ?= $(shell git describe --always)
dist_name = $(bin)-$(DIST_VERSION)
dist_tar_name = $(dist_name).tar

doc: $(manpath)

%.1: %.1.adoc
	$(ASCIIDOC) --backend manpage --doctype manpage $<
	test -f $@
	# Multiple manpage names can't be disabled but I don't want it.
	# asciidoctor/asciidoctor#1811
	$(RM) doc/git-abort.1

check:
	shellcheck $(bin)

clean:
	$(RM) doc/*.1

dist: $(dist_tar_name).gz

$(dist_tar_name).gz: $(manpath)
	mkdir -p $(dist_name)
	cp -t $(dist_name) $(bin) README.md
	mkdir -p $(dist_name)/doc
	cp $(manpath) $(dist_name)/doc
	cp install.mk $(dist_name)/Makefile
	tar cf $(dist_tar_name) $(dist_name)
	gzip -f -9 $(dist_tar_name)
	@$(RM) -r $(dist_name)

distclean:
	$(RM) $(bin)-*.gz
	$(RM) -r $(bin)-*/

release:
	test -n "$(v)"
	sed -i "s/^\(:man source: git continue\).\+$$/\1 $(v)/" $(manpath).adoc
	git add -p $(manpath).adoc
	git commit -m "$(bin) $(v)"
	git tag -a -m "$(bin) $(v)" "v$(v)"
