BUILT_SOURCES = _cmor.so

_cmor.so:
	$(LN_S) ../Src/.libs/_cmor.so _cmor.so

if BUILD_PYTHON
pypkglibdir = @pythondir@/@PACKAGE_NAME@
pypkglib_PYTHON = check_CMOR_compliant.py cmor_const.py git2svn.py __init__.py pywrapper.py
endif
