AC_PREREQ(2.52)

AC_INIT([apertium-kaz-tat], [0.2.1], [apertium-stuff@lists.sourceforge.net])
AM_INIT_AUTOMAKE
AC_PROG_AWK

PKG_CHECK_MODULES(APERTIUM, apertium >= 3.7.1)
PKG_CHECK_MODULES(APERTIUM_LEX_TOOLS, apertium-lex-tools >= 0.2.6)
PKG_CHECK_MODULES(HFST, hfst >= 3.15.3)
PKG_CHECK_MODULES(CG3, cg3 >= 1.3.2)

AC_PATH_PROG(GZCAT, gzcat, no)
AC_PATH_PROG(ZCAT, zcat, no)

if test x$ac_cv_path_GZCAT = xno
then
  if test x$ac_cv_path_ZCAT = xno
  then
    AC_MSG_ERROR([No working zcat installed.])
  else
    AC_SUBST(ZCAT,[zcat])
  fi
else
  AC_SUBST(ZCAT,[gzcat])
fi

m4_ifdef([AP_CHECK_LING],[],[AC_MSG_ERROR([AP_CHECK_LING not defined, is apertium.m4 in ACLOCAL_PATH? See: https://wiki.apertium.org/wiki/Installation_troubleshooting])])

AP_CHECK_LING([1], [apertium-kaz])
AP_CHECK_LING([2], [apertium-tat])

AP_MKINCLUDE

AC_OUTPUT([Makefile])
