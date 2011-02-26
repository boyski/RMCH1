# Copyright (c) 2002-2010 David Boyce.  All rights reserved.
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
## $() for normal make variables, e.g. ${DISPLAY} vs $(CFLAGS). A
## useful visual mnemonic, that's all.
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
## Directory values like $(Base) contain a trailing slash so you can
## (and should!) refer to $(Base)foobar rather than $(Base)/foobar which
## can result in subtle errors.

# Determine the root of the build tree.
export Base := $(dir $(realpath $(lastword ${MAKEFILE_LIST})))
#$(info Base=$(Base))

ifneq (,$(filter 3.7% 3.80% 3.81%, $(MAKE_VERSION)))
$(error Error: this makefile requires GNU make 3.82 or above)
endif

# Reserve 'all' early on as the default target.
.PHONY: all
all:

# Early infrastructure.
include $(Base)Vars.mk
include $(Base)Rules.mk

# Subdir makefiles.
include $(Base)libA/Makefile
include $(Base)libB/Makefile
include $(Base)cmd1/Makefile
include $(Base)cmd2/Makefile

# Late infrastructure.
include $(Base)Footer.mk
