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

mfd := $(dir $(abspath $(lastword ${MAKEFILE_LIST})))
ifndef BASE
include $(realpath $(mfd)..)/Makefile
else
###################### IGNORE ABOVE ###############################

ALL_PROGRAMS		+= $(mfd)cmd1
$(mfd)cmd1_OBJS		:= $(mfd)main.$o
$(mfd)cmd1_LIBS		:= libA.$a libB.$a libC.$a

# Includes must be at the bottom.
include $(mfd)libC/Makefile

###################### IGNORE BELOW ###############################
endif
