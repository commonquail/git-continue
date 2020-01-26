PREFIX ?= $(HOME)/.local
dest = $(DESTDIR)$(PREFIX)
bindir = $(dest)/bin
mandir = $(dest)/share/man/man1
bin = git-continue
manpage = $(bin).1
manpath = doc/$(manpage)

.PHONY: install
install: $(manpath)
	install -d $(bindir) $(mandir)
	install -m 0775 $(bin) $(bindir)
	install -m 0644 $(manpath) $(mandir)
	ln -sf $(bindir)/$(bin) $(bindir)/git-abort
	ln -sf $(mandir)/$(manpage) $(mandir)/git-abort.1

.PHONY: uninstall
uninstall:
	$(RM) $(bindir)/$(bin) $(bindir)/git-abort
	$(RM) $(mandir)/$(manpage) $(mandir)/git-abort.1
