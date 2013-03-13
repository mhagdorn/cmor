BUILT_SOURCES = cmor_locale.h

nobase_pkginclude_HEADERS = *.h cdTime/*.h cdTime/cdunifpp/*.h
EXTRA_DIST = cmor_locale.h.in
cmor_locale.h:	cmor_locale.h.in Makefile
		$(SED) -e 's|@pkgdatadir[@]|$(pkgdatadir)|g' $(srcdir)/$@.in >$@