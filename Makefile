# Copyright (C) 1989-2000, 2001, 2002, 2003, 2004, 2005, 2006, 2009, 2010
#   Free Software Foundation, Inc.
#      Written by James Clark (jjc@jclark.com)
# 
# This file is part of groff.
# 
# groff is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free
# Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# groff is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# Makefile.in
#
SHELL=/bin/sh

PACKAGE_TARNAME=groff-1.21

srcdir=.
top_srcdir=/usr/src/groff/groff-1.21

top_builddir=/usr/src/groff/groff-1.21

# `HOST' is the canonical host specification,
#    CPU_TYPE-MANUFACTURER-OPERATING_SYSTEM
# or
#    CPU_TYPE-MANUFACTURER-KERNEL-OPERATING_SYSTEM
HOST=x86_64-pc-linux-gnux32

# `RT_SEP' is the operating system's native PATH SEPARATOR CHAR, which
# is to be used in runtime PATHs compiled into groff executables.
RT_SEP=:

# `SH_SEP' is a alternative PATH SEPARATOR CHAR, to be used in shell
# scripts and makefile rules; it may be the same as `RT_SEP', but,
# particularly in some Microsoft environments, it may differ.
SH_SEP=:

# `GLIBC21' is yes if the host operating system uses GNU libc 2.1 or newer,
# otherwise no.
GLIBC21=yes

version=`cat $(top_srcdir)/VERSION`
# No additional number if revision is zero.
revision=`sed -e 's/^0$$//' -e 's/^[1-9].*$$/.&/' $(top_srcdir)/REVISION`

# Define `page' to be letter if your PostScript printer uses 8.5x11
# paper (USA) and define it to be A4, if it uses A4 paper (rest of the
# world).
PAGE=A4

# The name of the ghostscript program. Normally, gs, on GNU/Linux
# but it might be different on MS-DOS/MS-WIN32 systems.
GHOSTSCRIPT=gs

# `ALT_GHOSTSCRIPT_PROGS' specifies a list alternative names,
# which can be tried if `GHOSTSCRIPT' cannot be found at run time.
ALT_GHOSTSCRIPT_PROGS=gs gswin32c gsos2

# Similarly, `ALT_AWK_PROGS' specifies a list of alternative names,
# which can be tried at run time, to identify the awk program.
ALT_AWK_PROGS=gawk mawk nawk awk

# Normally the Postscript driver, grops, produces output that conforms
# to version 3.0 of the Adobe Document Structuring Conventions.
# Unfortunately some spoolers and previewers can't handle such output.
# The BROKEN_SPOOLER_FLAGS variable tells grops what it should do to
# make its output acceptable to such programs.  This variable controls
# only the default behaviour of grops; the behaviour can be changed at
# runtime by the grops -b option (and so by groff -P-b).
# Use a value of 0 if your spoolers and previewers are able to handle
# conforming PostScript correctly.
# Add 1 if no %%{Begin,End}DocumentSetup comments should be generated;
# this is needed for early versions of TranScript that get confused by
# anything between the %%EndProlog line and the first %%Page: comment.
# Add 2 if lines in included files beginning with %! should be
# stripped out; this is needed for the OpenWindows 2.0 pageview previewer.
# Add 4 if %%Page, %%Trailer and %%EndProlog comments should be
# stripped out of included files; this is needed for spoolers that
# don't understand the %%{Begin,End}Document comments. I suspect this
# includes early versions of TranScript.
# Add 8 if the first line of the PostScript output should be %!PS-Adobe-2.0
# rather than %!PS-Adobe-3.0; this is needed when using Sun's Newsprint
# with a printer that requires page reversal.
BROKEN_SPOOLER_FLAGS=0

# `DEVICE' is the default device.
DEVICE=ps

# `XDEVDIRS' is either `font/devX{75,100}{,-12}' or empty.
XDEVDIRS=font/devX75 font/devX75-12 font/devX100 font/devX100-12

# `XPROGDIRS' is either `src/devices/xditview src/utils/xtotroff' or empty.
XPROGDIRS=src/devices/xditview src/utils/xtotroff

# `XLIBDIRS' is either `src/libs/libxutil' or empty.
XLIBDIRS=src/libs/libxutil

# `TTYDEVDIRS' is either `font/devascii font/devlatin1' (for
# ASCII) or `font/devcp1047' (for EBCDIC) plus font/devutf8.
TTYDEVDIRS=font/devascii font/devlatin1 font/devutf8

# `OTHERDEVDIRS' is either `font/devlj4 font/devlbp' (for ASCII) or
# empty (for EBCDIC).
OTHERDEVDIRS=font/devlj4 font/devlbp

# `PSPRINT' is the command to use for printing a PostScript file,
# for example `lpr'.
PSPRINT=lpr

# `DVIPRINT' is the command to use for printing a TeX dvi file,
# for example `lpr -d'.
DVIPRINT=lpr -d

# Prefix for names of programs that have Unix counterparts.
# For example, if `g' is `g' then troff will be installed as
# gtroff.  This doesn't affect programs like grops or groff that have
# no Unix counterparts.  Note that the groff versions of eqn and tbl
# will not work with Unix troff.
g=

# Common prefix for installation directories.
# Used in definitions of exec_prefix, datasubdir, fontpath, manroot.
# This must already exist when you do make install.
prefix=/usr
exec_prefix=${prefix}

# `bindir' says where to install executables.
bindir=${exec_prefix}/bin

# `libdir' says where to install platform-dependent data.
libdir=/usr/libx32
libprogramdir=$(libdir)/groff

# `datasubdir' says where to install platform-independent data files.
datadir=${datarootdir}
datarootdir=${prefix}/share
dataprogramdir=$(datadir)/groff
datasubdir=$(dataprogramdir)/$(version)$(revision)

# `infodir' says where to install info files.
infodir=${datarootdir}/info

# `docdir' says where to install documentation files.
docdir=${datarootdir}/doc/${PACKAGE_TARNAME}

# `exampledir' says where to install example files.
exampledir=$(docdir)/examples

# `htmldocdir' says where to install documentation in HTML format.
htmldocdir=$(docdir)/html

# `pdfdocdir' says where to install documentation in PDF format.
pdfdocdir=$(docdir)/pdf

# `fontdir' says where to install dev*/*.
fontdir=$(datasubdir)/font

# `oldfontdir' says where to install old font sets (as dev*/*).
oldfontdir=$(datasubdir)/oldfont

# `localfontdir' says where local fonts will be installed (as dev*/*).
localfontdir=$(dataprogramdir)/site-font

# `legacyfontdir' is for compatibility with non-GNU troff.
legacyfontdir=/usr/lib/font

# `fontpath' says where to look for dev*/*.
fontpath=$(localfontdir)$(RT_SEP)$(fontdir)$(RT_SEP)$(legacyfontdir)

# `tmacdir' says where to install macros.
tmacdir=$(datasubdir)/tmac

# `systemtmacdir' says where to install platform-dependent macros.
systemtmacdir=$(libprogramdir)/site-tmac

# `localtmacdir' says where local files will be installed.
localtmacdir=$(dataprogramdir)/site-tmac

# `appresdir' says where to install the application resource file for
# gxditview.
appresdir=/usr/X11R7/lib64/X11/app-defaults

# `tmacpath' says where to look for macro files.
# The current directory will be prepended in unsafe mode only; the home
# directory will be always added.
# `troffrc' and `troffrc-end' (and `eqnrc') are searched neither in the
# current nor in the home directory.
tmacpath=$(systemtmacdir)$(RT_SEP)$(localtmacdir)$(RT_SEP)$(tmacdir)

# `sys_tmac_prefix' is prefix (if any) for system macro packages.
sys_tmac_prefix=

# `pnmtops_nosetpage' is the command to be run to generate an eps
# file.  Some versions of pnmtops provide the -nosetpage option.
# We detect this and use it if present.
pnmtops_nosetpage=pnmtops -nosetpage

# `tmac_wrap' is list of system macro packages that should be made
# available to groff by creating a corresponding macro package
# in the groff macro directory that references the system macro
# package.
tmac_wrap=

# If there is a groff version of a macro package listed in $(tmac_wrap),
# then the groff version will be installed with a prefix of this.
# Don't make this empty.
tmac_prefix=g

# The groff -mm macros will be available as -m$(tmac_m_prefix)m.
tmac_m_prefix=\
 `for i in $(tmac_wrap) ""; do case "$$i" in m) echo $(tmac_prefix);; esac; done`
# The groff -ms macros will be available as -m$(tmac_s_prefix)s.
tmac_s_prefix=\
 `for i in $(tmac_wrap) ""; do case "$$i" in s) echo $(tmac_prefix);; esac; done`
# The groff -man macros will be available as -m$(tmac_an_prefix)an.
tmac_an_prefix=\
 `for i in $(tmac_wrap) ""; do case "$$i" in an) echo $(tmac_prefix);; esac; done`

# Extension to be used for refer index files.  Index files are not
# sharable between different architectures, so you might want to use
# different suffixes for different architectures.  Choose an extension
# that doesn't conflict with refer or any other indexing program.
indexext=.i

# Directory containing the default index for refer.
indexdir=/usr/dict/papers

# The filename (without suffix) of the default index for refer.
indexname=Ind

# common_words_file is a file containing a list of common words.
# If your system provides /usr/lib/eign it will be copied onto this,
# otherwise the supplied eign file will be used.
common_words_file=$(datasubdir)/eign

# `manroot' is the root of the man page directory tree.
mandir=/usr/share/man
manroot=$(mandir)

# `man1ext' is the man section for user commands.
man1ext=1
man1dir=$(manroot)/man$(man1ext)

# `man5ext' is the man section for file formats.
man5ext=5
man5dir=$(manroot)/man$(man5ext)

# `man7ext' is the man section for macros.
man7ext=7
man7dir=$(manroot)/man$(man7ext)

# The configure script checks whether all necessary utility programs for
# grohtml are available -- only then we can build the HTML documentation.
make_html=html
make_install_html=install_html

# The configure script also checks whether all necessary utility programs
# for pdfroff are available -- only then we can build PDF documentation.
make_pdfdoc=pdfdoc
make_install_pdfdoc=install_pdfdoc

# All the previous installation directories, when used, are prefixed with
# $(DESTDIR) during install and uninstall, to support staged installations.

# DEFINES should include the following:
#
# -DWORDS_BIGENDIAN		if your target platform is big-endian
# -DIS_EBCDIC_HOST		if the host's encoding is EBCDIC
#
# -DHAVE_DIRECT_H		if you have <direct.h>
# -DHAVE_DIRENT_H		if you have <dirent.h>
# -DHAVE_CC_INTTYPES_H		if you have a C++ <inttypes.h>
# -DHAVE_PROCESS_H		if you have <process.h>
# -DHAVE_LIMITS_H		if you have <limits.h>
# -DHAVE_CC_LIMITS_H		if you have a C++ <limits.h>
# -DHAVE_MATH_H			if you have <math.h>
# -DHAVE_CC_OSFCN_H		if you have a C++ <osfcn.h>
# -DHAVE_STDDEF_H		if you have <stddef.h>
# -DHAVE_STDLIB_H		if you have <stdlib.h>
# -DHAVE_STRING_H		if you have <string.h>
# -DHAVE_STRINGS_H		if you have <strings.h>
# -DHAVE_SYS_DIR_H		if you have <sys/dir.h>
# -DHAVE_SYS_STAT_H		if you have <sys/stat.h>
# -DHAVE_SYS_TIME_H		if you have <sys/time.h>
# -DHAVE_SYS_TYPES_H		if you have <sys/types.h>
# -DHAVE_UNISTD_H		if you have <unistd.h>
#
# -DHAVE_FMOD			if you have fmod()
# -DHAVE_GETCWD			if you have getcwd()
# -DHAVE_GETTIMEOFDAY		if you have gettimeofday()
# -DHAVE_ICONV			if you have iconv()
# -DHAVE_ISATTY			if you have isatty()
# -DHAVE_KILL			if you have kill()
# -DHAVE_LANGINFO_CODESET	if you have nl_langinfo()
# -DHAVE_MKSTEMP		if you have mkstemp()
# -DHAVE_MMAP			if you have mmap()
# -DHAVE_PUTENV			if you have putenv()
# -DHAVE_RENAME			if you have rename()
# -DHAVE_SETLOCALE		if you have setlocale()
# -DHAVE_SNPRINTF		if you have snprintf()
# -DHAVE_STRCASECMP		if you have strcasecmp()
# -DHAVE_STRNCASECMP		if you have strncasecmp()
# -DHAVE_STRERROR		if you have strerror()
# -DHAVE_STRSEP			if you have strsep()
# -DHAVE_STRTOL			if you have strtol()
# -DHAVE_VSNPRINTF		if you have vsnprintf()
#
# -DNEED_DECLARATION_GETTIMEOFTODAY
#				if your C++ <sys/time.h> doesn't declare
#				gettimeofday()
# -DNEED_DECLARATION_HYPOT	if your C++ <math.h> doesn't declare hypot()
# -DNEED_DECLARATION_PCLOSE	if your C++ <stdio.h> doesn't declare pclose()
# -DNEED_DECLARATION_POPEN	if your C++ <stdio.h> doesn't declare popen()
# -DNEED_DECLARATION_PUTENV	if your C++ <stdlib.h> doesn't declare
#				putenv()
# -DNEED_DECLARATION_RAND	if your C++ <stdlib.h> doesn't declare rand()
# -DNEED_DECLARATION_SNPRINTF	if your C++ <stdio.h> doesn't declare
# 				snprintf()
# -DNEED_DECLARATION_SRAND	if your C++ <stdlib.h> doesn't declare srand()
# -DNEED_DECLARATION_STRCASECMP	if your C++ <string.h> doesn't declare
#				strcasecmp()
# -DNEED_DECLARATION_STRNCASECMP
#				if your C++ <string.h> doesn't declare
#				strncasecmp()
# -DNEED_DECLARATION_VFPRINTF	if your C++ <stdio.h> doesn't declare
#				vfprintf()
# -DNEED_DECLARATION_VSNPRINTF	if your C++ <stdio.h> doesn't declare
#				vsnprintf()
#
# -DHAVE_DECL_GETC_UNLOCKED	if you have getc_unlocked()
# -DHAVE_DECL_SYS_SIGLIST	if you have sys_siglist[]
#
# -DHAVE_STRUCT_EXCEPTION	if <math.h> defines struct exception
# -DHAVE_SYS_NERR		if you have sysnerr in <errno.h> or <stdio.h>
# -DHAVE_SYS_ERRLIST		if you have sys_errlist in <errno.h> or
#				<stdio.h>
# -DICONV_CONST=const		if declaration of iconv() needs const
# -DLONG_FOR_TIME_T		if localtime() takes a long * not a time_t *
# -DRETSIGTYPE=int		if signal handlers return int not void	
# -DRET_TYPE_SRAND_IS_VOID	if srand() returns void not int
#
# -DWCOREFLAG=0200		if the 0200 bit of the status returned by
#				wait() indicates whether a core image was
#				produced for a process that was terminated
#				by a signal
#
# -Duintmax_t=<value>		define to `unsigned long' or `unsigned long
#				long' if <inttypes.h> does not exist
#
# -DTRADITIONAL_CPP		if your C++ compiler uses a traditional
#				(Reiser) preprocessor
# -DARRAY_DELETE_NEEDS_SIZE	if your C++ doesn't understand `delete []'
#
# -DPAGE=A4			if the the printer's page size is A4
# -DGHOSTSCRIPT=gs		the name (and directory if required) of the
#				ghostscript program
#
DEFINES=-DHAVE_CONFIG_H

# Include
#
#   {fmod,getcwd,mkstemp,putenv,snprintf,strcasecmp,
#    strerror,strncasecmp,strtol}.$(OBJEXT)
#
# in LIBOBJS if your C library is missing the corresponding function.
# vsnprintf is defined in the snprintf.$(OBJEXT) module.
LIBOBJS=

# `CCC' is the compiler for C++ (.cpp) files.
CCC=x86_64-pc-linux-gnu-g++ -mx32 --sysroot=/build/x86_32
CC=x86_64-pc-linux-gnu-gcc -mx32 --sysroot=/build/x86_32
# CCDEFINES are definitions for C++ compilations.
CCDEFINES=$(DEFINES)
# CDEFINES are definitions for C compilations.
CDEFINES=$(DEFINES)

CCFLAGS=-g -O2
CFLAGS= -I/build/x86_32/include -I/build/x86_32/usr/include -I/build/x86_32/usr/X11R7/include -I/build/x86_32/usr/include/glib-2.0 -I/build/x86_32/usr/include/gtk-2.0 -I/build/x86_32/usr/include/dbus-1.0 -I/build/x86_32/usr/include/python2.7/ -I/build/x86_32/opt/qt-4/include
CPPFLAGS= -I/build/x86_32/include -I/build/x86_32/usr/include -I/build/x86_32/usr/X11R7/include -I/build/x86_32/usr/include/glib-2.0 -I/build/x86_32/usr/include/gtk-2.0 -I/build/x86_32/usr/include/dbus-1.0 -I/build/x86_32/usr/include/python2.7/ -I/build/x86_32/opt/qt-4/include
LDFLAGS=-L/build/x86_32/libx32 -L/build/x86_32/usr/libx32 -L/build/x86_32/lib -L/build/x86_32/usr/lib -L/build/x86_32/opt/qt-4/libx32 -L/build/x86_32/opt/qt-4/lib -L/build/x86_32/usr/X11R7/libx32 

X_CFLAGS= -I/build/x86_32/usr/X11R7/include
X_LIBS= -L/build/x86_32/usr/X11R7/lib64
X_EXTRA_LIBS=
X_PRE_LIBS= -lSM -lICE

YACC=bison -y
YACCFLAGS=-v

EGREP=/build/x86_32/usr/bin/grep -E

MAKEINFO=makeinfo

EXEEXT=
OBJEXT=o
LIBEXT=a
LIBS=
LIBM=-lm
LIBICONV=
RANLIB=x86_64-pc-linux-gnu-ranlib
INSTALL=/build/x86_32/bin/install -c
INSTALL_PROGRAM=${INSTALL}
INSTALL_SCRIPT=${INSTALL}
INSTALL_DATA=${INSTALL} -m 644
INSTALL_INFO=install-info
LN_S=ln -s
AR=ar
ETAGS=etags
ETAGSFLAGS=
# Flag that tells etags to assume C++.
ETAGSCCFLAG=-C
# Full path to perl.
PERLPATH=/usr/local/bin/perl
# Sed command with which to edit sh scripts.
SH_SCRIPT_SED_CMD=1s/a/a/
# Sed script to deal with OS dependencies in sh scripts.
SH_DEPS_SED_SCRIPT=$(top_builddir)/arch/misc/shdeps.sed

# The program to create directory hierarchies.
mkinstalldirs= $(SHELL) $(top_srcdir)/mkinstalldirs

PURIFY=purify
PURIFYCCFLAGS=
#PURIFYCCFLAGS=-g++=yes \
#  -collector=`dirname \`$(CCC) -print-libgcc-file-name\``/ld

# Passing down MAKEOVERRIDES prevents $(MAKE) from containing a second
# copy of $(MDEFINES) when making individual directories; this could
# cause the argument list to become too long on some systems.
MDEFINES= \
  "ALT_AWK_PROGS=$(ALT_AWK_PROGS)" \
  "ALT_GHOSTSCRIPT_PROGS=$(ALT_GHOSTSCRIPT_PROGS)" \
  "AR=$(AR)" \
  "BROKEN_SPOOLER_FLAGS=$(BROKEN_SPOOLER_FLAGS)" \
  "CC=$(CC)" \
  "CCC=$(CCC)" \
  "CCDEFINES=$(CCDEFINES)" \
  "CCFLAGS=$(CCFLAGS)" \
  "CDEFINES=$(CDEFINES)" \
  "CFLAGS=$(CFLAGS)" \
  "CPPFLAGS=$(CPPFLAGS)" \
  "DEVICE=$(DEVICE)" \
  "DVIPRINT=$(DVIPRINT)" \
  "EGREP=$(EGREP)" \
  "ETAGS=$(ETAGS)" \
  "ETAGSCCFLAG=$(ETAGSCCFLAG)" \
  "ETAGSFLAGS=$(ETAGSFLAGS)" \
  "EXEEXT=$(EXEEXT)" \
  "GLIBC21=$(GLIBC21)" \
  "HOST=$(HOST)" \
  "INSTALL_DATA=$(INSTALL_DATA)" \
  "INSTALL_INFO=$(INSTALL_INFO)" \
  "INSTALL_PROGRAM=$(INSTALL_PROGRAM)" \
  "INSTALL_SCRIPT=$(INSTALL_SCRIPT)" \
  "LDFLAGS=$(LDFLAGS)" \
  "LIBEXT=$(LIBEXT)" \
  "LIBICONV=$(LIBICONV)" \
  "LIBM=$(LIBM)" \
  "LIBOBJS=$(LIBOBJS)" \
  "LIBS=$(LIBS)" \
  "MAKEINFO=$(MAKEINFO)" \
  "MAKEOVERRIDES=$(MAKEOVERRIDES)" \
  "OBJEXT=$(OBJEXT)" \
  "OTHERDEVDIRS=$(OTHERDEVDIRS)" \
  "PAGE=$(PAGE)" \
  "GHOSTSCRIPT=$(GHOSTSCRIPT)" \
  "PERLPATH=$(PERLPATH)" \
  "PSPRINT=$(PSPRINT)" \
  "PURIFY=$(PURIFY)" \
  "PURIFYCCFLAGS=$(PURIFYCCFLAGS)" \
  "RANLIB=$(RANLIB)" \
  "RT_SEP=$(RT_SEP)" \
  "SH_SEP=$(SH_SEP)" \
  "SHELL=$(SHELL)" \
  "SH_SCRIPT_SED_CMD=$(SH_SCRIPT_SED_CMD)" \
  "SH_DEPS_SED_SCRIPT=$(SH_DEPS_SED_SCRIPT)" \
  "TTYDEVDIRS=$(TTYDEVDIRS)" \
  "XDEVDIRS=$(XDEVDIRS)" \
  "XLIBDIRS=$(XLIBDIRS)" \
  "XPROGDIRS=$(XPROGDIRS)" \
  "X_CFLAGS=$(X_CFLAGS)" \
  "X_LIBS=$(X_LIBS)" \
  "X_EXTRA_LIBS=$(X_EXTRA_LIBS)" \
  "X_PRE_LIBS=$(X_PRE_LIBS)" \
  "YACC=$(YACC)" \
  "YACCFLAGS=$(YACCFLAGS)" \
  "appresdir=$(appresdir)" \
  "bindir=$(bindir)" \
  "common_words_file=$(common_words_file)" \
  "datadir=$(datadir)" \
  "dataprogramdir=$(dataprogramdir)" \
  "datasubdir=$(datasubdir)" \
  "docdir=$(docdir)" \
  "exampledir=$(exampledir)" \
  "exec_prefix=$(exec_prefix)" \
  "fontdir=$(fontdir)" \
  "fontpath=$(fontpath)" \
  "g=$(g)" \
  "htmldocdir=$(htmldocdir)" \
  "pdfdocdir=$(pdfdocdir)" \
  "indexdir=$(indexdir)" \
  "indexext=$(indexext)" \
  "indexname=$(indexname)" \
  "infodir=$(infodir)" \
  "legacyfontdir=$(legacyfontdir)" \
  "libdir=$(libdir)" \
  "libprogramdir=$(libprogramdir)" \
  "localfontdir=$(localfontdir)" \
  "localtmacdir=$(localtmacdir)" \
  "make_html=$(make_html)" \
  "make_install_html=$(make_install_html)" \
  "make_pdfdoc=$(make_pdfdoc)" \
  "make_install_pdfdoc=$(make_install_pdfdoc)" \
  "man1dir=$(man1dir)" \
  "man1ext=$(man1ext)" \
  "man5dir=$(man5dir)" \
  "man5ext=$(man5ext)" \
  "man7dir=$(man7dir)" \
  "man7ext=$(man7ext)" \
  "manroot=$(manroot)" \
  "mkinstalldirs=$(mkinstalldirs)" \
  "oldfontdir=$(oldfontdir)" \
  "pnmtops_nosetpage=$(pnmtops_nosetpage)" \
  "prefix=$(prefix)" \
  "revision=$(revision)" \
  "sys_tmac_prefix=$(sys_tmac_prefix)" \
  "systemtmacdir=$(systemtmacdir)" \
  "tmac_an_prefix=$(tmac_an_prefix)" \
  "tmac_m_prefix=$(tmac_m_prefix)" \
  "tmac_s_prefix=$(tmac_s_prefix)" \
  "tmac_wrap=$(tmac_wrap)" \
  "tmacdir=$(tmacdir)" \
  "tmacpath=$(tmacpath)" \
  "top_builddir=$(top_builddir)" \
  "top_srcdir=$(top_srcdir)" \
  "version=$(version)"

MAKE_K_FLAG=`case "$(MAKEFLAGS)" in *k*) echo ' -k ';; esac`

INCDIRS=\
  src/include
LIBDIRS=\
  src/libs/libgroff \
  src/libs/libdriver \
  src/libs/libbib \
  $(XLIBDIRS)
CCPROGDIRS=\
  src/roff/groff \
  src/roff/troff \
  src/preproc/preconv \
  src/preproc/tbl \
  src/preproc/pic \
  src/preproc/eqn \
  src/preproc/grn \
  src/preproc/refer \
  src/preproc/soelim \
  src/preproc/html \
  src/devices/grops \
  src/devices/grotty \
  src/devices/grodvi \
  src/devices/grolj4 \
  src/devices/grohtml \
  src/devices/grolbp \
  src/utils/tfmtodit \
  src/utils/hpftodit \
  src/utils/lookbib \
  src/utils/indxbib \
  src/utils/lkbib \
  src/utils/addftinfo
CPROGDIRS=\
  src/utils/pfbtops
PROGDEPDIRS=\
  arch/misc
PROGDIRS=\
  $(PROGDEPDIRS) \
  $(CCPROGDIRS) \
  $(CPROGDIRS) \
  $(XPROGDIRS)
DEVDIRS=\
  font/devps \
  font/devdvi \
  font/devhtml
ALLTTYDEVDIRS=\
  font/devascii \
  font/devlatin1 \
  font/devutf8 \
  font/devcp1047
# `doc' must be processed before `contrib/pdfmark'.
OTHERDIRS=\
  man \
  tmac \
  src/utils/afmtodit \
  src/roff/grog \
  src/roff/nroff \
  doc \
  contrib/mm \
  contrib/chem \
  contrib/pic2graph \
  contrib/eqn2graph \
  contrib/grap2graph \
  contrib/groffer \
  contrib/mom \
  contrib/hdtbl \
  contrib/pdfmark \
  contrib/gdiffmk
ALLDIRS=\
  $(INCDIRS) \
  $(LIBDIRS) \
  $(PROGDIRS) \
  $(DEVDIRS) \
  $(XDEVDIRS) \
  $(OTHERDEVDIRS) \
  $(TTYDEVDIRS) \
  $(OTHERDIRS)
EXTRADIRS=\
  font/devps/generate \
  font/devdvi/generate \
  font/devlj4/generate \
  doc
NOMAKEDIRS=\
  m4 \
  arch/djgpp \
  contrib/chem/examples \
  contrib/chem/examples/122 \
  contrib/groffer/perl \
  contrib/groffer/shell \
  contrib/hdtbl/examples \
  contrib/mm/examples \
  contrib/mm/mm \
  contrib/mom/examples \
  contrib/mom/momdoc \
  contrib/gdiffmk/tests \
  src/libs/snprintf \
  src/libs/gnulib/lib \
  src/libs/gnulib/lib/uniwidth \
  src/libs/gnulib/m4 \
  src/libs/gnulib/build-aux \
  src/libs/gnulib \
  font/devps/old \
  font/util
GNULIBDIRS=\
  src/libs/gnulib
DISTDIRS=\
  $(INCDIRS) \
  $(LIBDIRS) \
  $(PROGDIRS) \
  $(DEVDIRS) \
  $(XDEVDIRS) \
  $(OTHERDEVDIRS) \
  $(ALLTTYDEVDIRS) \
  $(OTHERDIRS) \
  $(EXTRADIRS) \
  $(NOMAKEDIRS) \
  $(GNULIBDIRS)
TARGETS=\
  all \
  install_bin install_data \
  clean distclean mostlyclean realclean extraclean \
  distfiles \
  TAGS \
  depend \
  uninstall_sub \
  fonts

# This ENVSETUP gork is required by the DJGPP build on Windows 9X,
# where Make needs to be case-sensitive to find files like BI and VERSION.
ENVSETUP=\
	if test -f $(srcdir)/makefile.ccpg* && \
	   test -f $(srcdir)/Makefile.ccpg*; then \
	  FNCASE=y; export FNCASE; \
	else :; \
	fi

do=all
dodirs=$(ALLDIRS) dot
# Default target for subdir_Makefile
subdir=src/roff/troff


$(TARGETS):
	@$(ENVSETUP); $(MAKE) $(MAKE_K_FLAG) $(MDEFINES) do=$@ $(dodirs)

dot: FORCE
	@$(ENVSETUP); \
	$(MAKE) $(MAKE_K_FLAG) $(MDEFINES) srcdir=$(srcdir) VPATH=$(srcdir) \
	  -f $(top_srcdir)/Makefile.comm \
	  -f $(top_srcdir)/Makefile.sub $(do)

$(LIBDIRS): FORCE $(INCDIRS) $(PROGDEPDIRS) $(GNULIBDIRS)
	@$(ENVSETUP); \
	if test $(srcdir) = .; then \
	  srcdir=.; \
	else \
	  srcdir=`cd $(srcdir); pwd`/$@; \
	fi; \
	test -d $@ || $(mkinstalldirs) $@; \
	cd $@; \
	test -f Makefile.dep || touch Makefile.dep; \
	$(MAKE) $(MAKE_K_FLAG) $(MDEFINES) srcdir=$$srcdir VPATH=$$srcdir \
	  -f $(top_srcdir)/Makefile.comm \
	  -f $$srcdir/Makefile.sub \
	  -f $(top_srcdir)/Makefile.lib \
	  -f Makefile.dep $(do)

$(CPROGDIRS) $(XPROGDIRS): FORCE $(LIBDIRS)
	@$(ENVSETUP); \
	if test $(srcdir) = .; then \
	  srcdir=.; \
	else \
	  srcdir=`cd $(srcdir); pwd`/$@; \
	fi; \
	test -d $@ || $(mkinstalldirs) $@; \
	cd $@; \
	test -f Makefile.dep || touch Makefile.dep; \
	$(MAKE) $(MAKE_K_FLAG) $(MDEFINES) srcdir=$$srcdir VPATH=$$srcdir \
	  -f $(top_srcdir)/Makefile.comm \
	  -f $$srcdir/Makefile.sub \
	  -f $(top_srcdir)/Makefile.cpg \
	  -f Makefile.dep $(do)

$(CCPROGDIRS): FORCE $(LIBDIRS)
	@$(ENVSETUP); \
	if test $(srcdir) = .; then \
	  srcdir=.; \
	else \
	  srcdir=`cd $(srcdir); pwd`/$@; \
	fi; \
	test -d $@ || $(mkinstalldirs) $@; \
	cd $@; \
	test -f Makefile.dep || touch Makefile.dep; \
	$(MAKE) $(MAKE_K_FLAG) $(MDEFINES) srcdir=$$srcdir VPATH=$$srcdir \
	  -f $(top_srcdir)/Makefile.comm \
	  -f $$srcdir/Makefile.sub \
	  -f $(top_srcdir)/Makefile.ccpg \
	  -f Makefile.dep $(do)

$(DEVDIRS) $(XDEVDIRS) $(OTHERDEVDIRS) $(TTYDEVDIRS): FORCE $(PROGDEPDIRS) $(CCPROGDIRS) $(CPROGDIRS)
	@$(ENVSETUP); \
	if test $(srcdir) = .; then \
	  srcdir=.; \
	else \
	  srcdir=`cd $(srcdir); pwd`/$@; \
	fi; \
	test -d $@ || $(mkinstalldirs) $@; \
	cd $@; \
	$(MAKE) $(MAKE_K_FLAG) $(MDEFINES) srcdir=$$srcdir VPATH=$$srcdir \
	  -f $(top_srcdir)/Makefile.comm \
	  -f $$srcdir/Makefile.sub \
	  -f $(top_srcdir)/Makefile.dev $(do)

$(GNULIBDIRS): FORCE
	@$(ENVSETUP); \
	if test $(srcdir) = .; then \
	  srcdir=.; \
	else \
	  srcdir=`cd $(srcdir); pwd`/$@; \
	fi; \
	test -d $@ || $(mkinstalldirs) $@; \
	case $(do) in \
	all) \
	cd $@; \
	test -f Makefile || $(SHELL) $$srcdir/configure ; \
	$(MAKE) ACLOCAL=: AUTOCONF=: AUTOHEADER=: AUTOMAKE=: $(do) ;; \
	esac

$(OTHERDIRS): $(PROGDEPDIRS) $(CCPROGDIRS) $(CPROGDIRS)

$(INCDIRS) $(PROGDEPDIRS) $(OTHERDIRS): FORCE
	@$(ENVSETUP); \
	if test $(srcdir) = .; then \
	  srcdir=.; \
	else \
	  srcdir=`cd $(srcdir); pwd`/$@; \
	fi; \
	test -d $@ || $(mkinstalldirs) $@; \
	cd $@; \
	$(MAKE) $(MAKE_K_FLAG) $(MDEFINES) srcdir=$$srcdir VPATH=$$srcdir \
	  -f $(top_srcdir)/Makefile.comm \
	  -f $$srcdir/Makefile.sub \
	  -f $(top_srcdir)/Makefile.man $(do)

.PHONY: dist
dist:
	-rm -fr tmp
	rm -f groff-$(version)$(revision).tar.gz
	mkdir tmp
	for d in $(DISTDIRS); do \
	  $(mkinstalldirs) tmp/$$d; \
	done
	srcdir=`cd $(srcdir); pwd`; \
	cd tmp; \
	cp ../Makefile .; \
	cp $$srcdir/* . 2>/dev/null || true; \
	rm -rf CVS; \
	for d in $(DISTDIRS); do \
	  (cd $$d; \
	   cp $$srcdir/$$d/* . 2>/dev/null; \
	   rm -rf CVS || true); \
	done; \
	$(MAKE) srcdir=. VPATH=. distfiles; \
	$(MAKE) srcdir=. VPATH=. extraclean; \
	for d in $(EXTRADIRS); do \
	  (cd $$d; \
	   if test -f Makefile; then \
	     $(MAKE) extraclean; \
	   else \
	     $(MAKE) -f $(top_builddir)/$$d/Makefile extraclean; \
	   fi); \
	done; \
	rm -f Makefile; \
	cp $$srcdir/Makefile.init Makefile
	mv tmp groff-$(version)$(revision)
	tar cfh - groff-$(version)$(revision) | \
	  gzip -c >groff-$(version)$(revision).tar.gz
	rm -fr groff-$(version)$(revision)

# $(PROGDIRS): libgroff
# grops grotty grodvi: libdriver
# refer lookbib indxbib lkbib: libbib
# $(LIBDIRS) $(PROGDIRS): include

.PHONY: $(ALLDIRS) dot $(TARGETS) FORCE

# Create a Makefile in $(subdir).  This is useful for development since it
# avoids running make recursively.
subdir_Makefile: Makefile.cfg
	$(MAKE) do=Makefile $(subdir)

Makefile.cfg: Makefile
	>Makefile.cfg
	for var in $(MDEFINES); do \
	  echo "$$var" >>Makefile.cfg; \
	done

Makefile: Makefile.in
	$(SHELL) config.status

.PHONY: install
install:
	-test -d $(DESTDIR)$(prefix) \
	  || $(mkinstalldirs) $(DESTDIR)$(prefix)
	@$(ENVSETUP); $(MAKE) $(MAKE_K_FLAG) $(MDEFINES) \
	  do=do_install $(dodirs)
	cd $(DESTDIR)$(dataprogramdir); \
	rm -f current; \
	$(LN_S) $(version)$(revision) current

.PHONY: uninstall
uninstall: uninstall_sub uninstall_dirs

.PHONY: uninstall_dirs
# Use `rmdir' here so that the directories are only removed if they are empty.
uninstall_dirs:
	-rm -f $(dataprogramdir)/current
	-rmdir $(man1dir) $(man5dir) $(man7dir) $(manroot) \
	  $(tmacdir) $(systemtmacdir) $(localtmacdir) \
	  $(fontdir) $(localfontdir) $(oldfontdir) $(bindir) \
	  $(datasubdir) $(dataprogramdir) $(infodir) \
	  $(exampledir) $(htmldocdir) $(pdfdocdir) $(docdir) \
	  $(libprogramdir) $(libdir) \
	  $(datadir)/doc/groff $(datadir)/doc $(datadir) 2>/dev/null || :

.PHONY: check
check:
	@echo There is no validation suite for this package.

#check: site.exp docheck
#.PHONY: docheck

#docheck:
#	if $(SHELL) -c "runtest --version" > /dev/null 2>&1; then \
#	  runtest; \
#	else \
#	  echo "WARNING: could not find \`runtest'" 1>&2; \
#	fi

# This snippet has been taken from the automake package.

#site.exp:
#	@echo "Making a new site.exp file..."
#	@echo "## these variables are automatically generated by make ##" >site.tmp
#	@echo "# Do not edit here.  If you wish to override these values" >>site.tmp
#	@echo "# edit the last section" >>site.tmp
#	@echo "set tool groff" >>site.tmp
#	@echo "set srcdir $(srcdir)/testsuite" >>site.tmp
#	@echo "set objdir `pwd`" >> site.tmp
#	@echo "## All variables above are generated by configure.  Do not edit! ##" >> site.tmp
#	@test ! -f site.exp \
#	  || sed '1,/^## All variables above are.*##/ d' site.exp >> site.tmp
#	@-rm -f site.bak
#	@test ! -f site.exp || mv site.exp site.bak
#	@mv site.tmp site.exp

FORCE:

.NOEXPORT:
