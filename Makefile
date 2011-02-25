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

# Determine the root of the build tree.
export BASE := $(dir $(abspath $(lastword ${MAKEFILE_LIST})))
$(info BASE=$(BASE))

ifneq (,$(filter 3.7% 3.80% 3.81%, $(MAKE_VERSION)))
$(error Error: this makefile requires GNU make 3.82 or above)
endif

# Reserve 'all' as the default target.
.PHONY: all
all:

# Early infrastructure.
include $(BASE)/Vars.mk
include $(BASE)/Rules.mk

# Subdir makefiles.
include $(BASE)libA/Makefile
include $(BASE)libB/Makefile
include $(BASE)cmd1/Makefile

# Late infrastructure.
include $(BASE)Footer.mk
