:# SYNOPSIS
#
#   ACX_UDUNITS2([ACTION-IF-FOUND[, ACTION-IF-NOT-FOUND]])
#
# DESCRIPTION
#
# This macro looks for the UDUNITS2 library
#
#
#   ACTION-IF-FOUND is a list of shell commands to run if the UDUNITS2 library
#   is found, and ACTION-IF-NOT-FOUND is a list of commands to run it if it
#   is not found. If ACTION-IF-FOUND is not specified, the default action
#   will define HAVE_UDUNITS2.
#
#   This macro will set the following variables
#   UDUNITS2_LIBS UDUNITS2_CPPFLAGS UDUNITS2_LDFLAGS
#
# LICENSE
#
#   Copyright (c) 2009 Magnus Hagdorn <Magnus.Hagdorn@ed.ac.uk>
#
#   This program is free software: you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation, either version 3 of the License, or (at your
#   option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
#   Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program. If not, see <http://www.gnu.org/licenses/>.
#
#   As a special exception, the respective Autoconf Macro's copyright owner
#   gives unlimited permission to copy, distribute and modify the configure
#   scripts that are the output of Autoconf when processing the Macro. You
#   need not follow the terms of the GNU General Public License when using
#   or distributing such scripts, even though portions of the text of the
#   Macro appear in them. The GNU General Public License (GPL) does govern
#   all other use of the material that constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the Autoconf
#   Macro released by the Autoconf Archive. When you make and distribute a
#   modified version of the Autoconf Macro, you may extend this special
#   exception to the GPL to apply to your modified version as well.

AC_DEFUN([ACX_UDUNITS2], [

acx_udunits2_ok=no

CPPFLAGSsave=$CPPFLAGS
LIBSsave=$LIBS
LDFLAGSsave=$LDFLAGS
UDUNITS2_LIBS=""
UDUNITS2_LDFLAGS=""
UDUNITS2_CPPFLAGS=""

AC_ARG_WITH(udunits2,
  [AS_HELP_STRING([--with-udunits2],[root directory path where UDUNITS2 is installed. (defaults to /usr/local or /usr if not found in /usr/local)])],
  [],
  [with_udunits2=yes])


# check whether udunits2 is disabled
AC_MSG_CHECKING([for udunits2])
AC_MSG_RESULT($with_udunits2)
AS_IF([test "x$with_udunits2" != xno],
      [ 
	udunits2_inc_path=""
	udunits2_lib_path=""
        # check if with_udunits2 is a path and if so setup various search paths
        if test -d "$with_udunits2"; then
          udunits2_inc_path="$with_udunits2"/include
          udunits2_lib_path="$with_udunits2"/lib
        fi
        # check whether we should use a non standard include path
        AC_ARG_WITH(udunits2-include,
          [AS_HELP_STRING([--with-udunits2-include],[path to where udunits2 header files can be found])],
          [
           if test -d "$withval"; then
               udunits2_inc_path=$withval
           else
               AC_MSG_ERROR([Cannot find directory "$withval"])
           fi
          ])

        # check whether we should use a non standard library path
        AC_ARG_WITH(udunits2-lib,
          [AS_HELP_STRING([--with-udunits2-lib],[path to where udunits2 library files can be found])],
          [
           if test -d "$withval"; then
               udunits2_lib_path="$withval"
           else
               AC_MSG_ERROR([Cannot find directory "$withval"])
           fi
          ])
        
        if test x"$udunits2_inc_path"x != xx ; then
           UDUNITS2_CPPFLAGS=-I"$udunits2_inc_path"
        fi
        if test x"$udunits2_lib_path"x != xx ; then
           UDUNITS2_LDFLAGS=-L"$udunits2_lib_path"
        fi

	# check for libraries
	LDFLAGS="$LDFLAGS $UDUNITS2_LDFLAGS"
        # we always need to link to the C libraries, so let's look for them
        AC_LANG_PUSH([C])
        CPPFLAGS="$CPPFLAGS $UDUNITS2_CPPFLAGS"
	AC_CHECK_LIB(udunits2,ut_parse,[acx_udunits2_ok=yes; UDUNITS2_LIBS="-ludunits2"],[acx_udunits2_ok=no])
        AC_LANG_POP([C])

        # figure out how to use UDUNITS2 from various languages
        AC_LANG_CASE(
        [C],[
	AC_CHECK_HEADER([udunits2.h],[acx_udunits2_ok=yes],[acx_udunits2_ok=no])
        ],
        [C++],[AC_MSG_NOTICE([C++ not checked for yet])],
        [Fortran 77],[AC_MSG_NOTICE([F77 not checked for yet])],
        [Fortran],[AC_MSG_NOTICE([Fortran not checked for yet])])
      ])

AC_SUBST(UDUNITS2_LIBS)
AC_SUBST(UDUNITS2_LDFLAGS)
AC_SUBST(UDUNITS2_CPPFLAGS)

# reset variables to original values
CPPFLAGS=$CPPFLAGSsave
LIBS=$LIBSsave
LDFLAGS=$LDFLAGSsave
  
# Finally, execute ACTION-IF-FOUND/ACTION-IF-NOT-FOUND:
if test x"$acx_udunits2_ok" = xyes; then
        ifelse([$1],,AC_DEFINE(HAVE_UDUNITS2,1,[Define if you have the UDUNITS2 library.]),[$1])
        :
else
        acx_udunits2_ok=no
        $2
fi
])dnl ACX_UDUNITS2
