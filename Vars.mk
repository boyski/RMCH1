ifndef VARS_
VARS_ := 1

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

# Initialize general purpose make variables. This is where the
# decision about simply- vs recursively-expanded is made, because
# the += operator respects the previous state but defaults to
# recursive. Therefore, if a variable can be simply-expanded
# it's a good idea to initialize it with := here.

PrereqFiles		:=
IntermediateTargets	:=
FinalTargets		:=

AllArchives		:=
AllPrograms		:=

IncDir			:= $(Base)include
LibDir			:= $(Base)lib

# It's critical that directories never be *created* in recipes
# because that leads to a race condition under -j. This method
# is guaranteed to be single-threaded.
$(shell [ -d $(LibDir) ] || set -x; mkdir -p $(LibDir))

CFLAGS			+= -I$(IncDir)
LDFLAGS			+=

CC			:= gcc

a			:= a
o			:= o

endif #VARS_
