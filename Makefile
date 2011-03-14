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

##	CODING CONVENTIONS
##
## Make offers two equivalent ways of expanding variables: $() and ${}.
## We try to use ${} for variables derived from the environment and
## $() for normal make variables, e.g. ${DISPLAY} vs $(CFLAGS). It's a
## useful visual mnemonic and allows the output of "make -n" to remain
## parameterized and be pasted directly into a shell, as demo-ed here.
##
## Variable (aka macro) case is as follows: UPPERCASE for make
## builtins, variables inherited from the environment, and "parameter
## variables" (see below), CamelCase for internally-defined variables
## with logically global scope, and lowercase for those with logically
## limited scope. Since make does not offer actual lexical scoping
## this latter distinction is more a matter of style than
## language. This is more or less in line with the GNU Make
## Manual which says "It is traditional to use upper case letters
## in variable names, but we recommend using lower case letters
## for variable names that serve internal purposes in the
## makefile, and reserving upper case for parameters that control
## implicit rules or for parameters that the user should override
## with command options."
##
## Directory values like $(BaseDir) contain a trailing slash so you can
## (and should!) refer to $(BaseDir)foobar rather than $(BaseDir)/foobar which
## can result in subtle errors.

# Determine the root of the build tree. There's one variable
# which is used internally to make, and another with the same
# value which is exported for use in recipes.
BaseDir := $(dir $(realpath $(lastword ${MAKEFILE_LIST})))
export BASE := $(BaseDir)

ifneq (,$(filter 3.7% 3.80%,$(MAKE_VERSION)))
$(error Error: GNU make 3.81 or above required)
endif

# Make sure the log file contains a record of the invocation.
ifeq (,$(filter %clean,$(MAKECMDGOALS)))
$(info + export BASE=$(BASE))
$(info + "$(strip $(MAKE) $(MFLAGS) -f $(firstword $(MAKEFILE_LIST)) $(MAKECMDGOALS))" in $(CURDIR))
endif

# Reserve 'all' early on as the default target.
.PHONY: all
all:

# All rules used here should be explicit.
.SUFFIXES:

# Early infrastructure.
include $(BaseDir)Vars.mk

vpath %.$a $(LibDir)

# Subdir makefiles.
include $(BaseDir)libA/Makefile
include $(BaseDir)libB/Makefile
include $(BaseDir)cmd1/Makefile
include $(BaseDir)cmd2/Makefile
include $(BaseDir)cmd3/Makefile

# Late infrastructure.
include $(BaseDir)Footer.mk
