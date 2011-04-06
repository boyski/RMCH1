# Copyright (c) 2002-2011 David Boyce.  All rights reserved.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

######################################################################
##	CHANGES
##
## If a directory is moved, it's necessary to change the path by
## which its Makefile included below. That should be the only
## non-local change required. Similarly, if a new directory is
## created its Makefile must be added to the list below.
######################################################################

######################################################################
##	CODING CONVENTIONS
##
## Make offers two equivalent ways of expanding variables: $() and ${}.
## We try to use ${} for variables derived from the environment and
## $() for normal make variables, e.g. ${DISPLAY} vs $(CFLAGS). It's a
## useful visual mnemonic and allows the output of "make -n" to remain
## parameterized and be pasted directly into a shell.
##
## Variable (aka macro) case is as follows: UPPERCASE for make
## builtins, variables inherited from the environment, and "parameter
## variables" (see below), CamelCase for internally-defined variables
## with logically global scope, lowercase for those with logically
## limited scope, and a leading underscore for thos which are not for
## the eyes of users. Since make does not offer actual lexical scoping,
## observing the conventions is particularly important.
## The above is more or less in line with the GNU Make
## Manual which says "It is traditional to use upper case letters
## in variable names, but we recommend using lower case letters
## for variable names that serve internal purposes in the
## makefile, and reserving upper case for parameters that control
## implicit rules or for parameters that the user should override
## with command options."
##
## Directory values like $(SrcBase) contain a trailing slash so you can
## (and should!) refer to $(SrcBase)foobar rather than $(SrcBase)/foobar
## which can result in subtle errors. An advantage of this is that
## when SrcBase == ".", which is the typical case, if ${SrcBase}
## evaluates to the null string (such as when pasted into a test script)
## everything will still work.
######################################################################

# This hasn't been tested on anything older than 3.81.
ifneq (,$(filter 3.7% 3.80%,$(MAKE_VERSION)))
$(error Error: GNU make 3.81 or above required)
endif

MakeFile := $(firstword $(MAKEFILE_LIST))

# Determine the root of the source tree. There's one variable
# which is used internally to make, and another with the same
# value which is exported for use in recipes.
SrcBase := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# Determine the target architecture and its directory.
ifdef VSINSTALLDIR
/	:= $(subst .,\,.)
/	:= /
SrcBase := $(patsubst /h/%,h:/%,$(SrcBase))
Arch := Windows_i386
_tbase := $(SrcBase)$(Arch)
$(shell test -d $(_tbase) || mkdir $(_tbase))
else
/	:= /
Arch := $(shell uname -s)_$(shell uname -m)
_tbase := $(SrcBase)$(Arch)
$(shell [ -d $(_tbase) ] || mkdir -p $(_tbase))
endif
TgtBase := $(realpath $(_tbase))$/
export TBASE := $(TgtBase)
export SBASE := $(SrcBase)

# Make sure any log file will contain a record of the invocation.
ifeq (,$(filter %clean help% print-%,$(MAKECMDGOALS)))
$(info + export SBASE=$(SBASE) TBASE=$(subst ${SBASE},$${SBASE},$(TBASE)))
$(info + "$(strip $(MAKE) $(MFLAGS) -f $(MakeFile) $(MAKECMDGOALS))" in $(CURDIR))
endif

# Need this early - support for help target.
show-help = $(if $(filter help,$(MAKECMDGOALS)),$(info $1 -- $2))

# Reserve 'all' early on as the default target.
.PHONY: all
all: $(call show-help,all,DEFAULT: Build all known target files)

# All rules used here should be explicit.
.SUFFIXES:

# Early infrastructure.
include $(SrcBase)Vars.mk

vpath %.$a $(LibDir)

# Pull in all involved subdirectories.
include $(SrcBase)SubDirs.mk
include $(addprefix $(SrcBase),$(addsuffix $/Makefile,$(SubDirs)))

# Late infrastructure.
include $(SrcBase)Footer.mk
