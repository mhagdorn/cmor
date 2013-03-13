lib_LTLIBRARIES = libcmor.la $(flib)

libcmor_la_SOURCES = cmor.c cmor_variables.c cmor_axes.c cmor_tables.c cmor_grids.c cdTime/cdTimeConv.c cdTime/cdUtil.c \
                     cdTime/timeConv.c cdTime/timeArith.c cmor_md5.c
libcmor_la_LIBADD = $(UDUNITS2_LIBS) $(NETCDF_LIBS) $(UUID_LIBS)

libcmorf_la_SOURCES = cmor_cfortran_interface.c cmor_fortran_interface.f90
libcmorf_la_LIBADD = libcmor.la 

AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/include/cdTime $(UDUNITS2_CPPFLAGS)
AM_LDFLAGS = $(UDUNITS2_LDFLAGS) $(NETCDF_LDFLAGS)
CLEANFILES = *.mod

if BUILD_FORTRAN
flib = libcmorf.la
endif

if BUILD_PYTHON
pypkglibdir = @pythondir@/@PACKAGE_NAME@
pypkglib_LTLIBRARIES = _cmor.la
_cmor_la_SOURCES = _cmormodule.c
_cmor_la_CPPFLAGS = $(AM_CPPFLAGS) $(PYTHON_CPPFLAGS) $(NUMPY_CPPFLAGS)
_cmor_la_LDFLAGS = -module -shared -avoid-version $(AM_LDFLAGS)
_cmor_la_LIBADD = libcmor.la
endif