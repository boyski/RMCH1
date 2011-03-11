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

Space			:=
Space			+=

TgtFilter		:=

PrereqFiles		:=
IntermediateTargets	:=
FinalTargets		:=

AllArchives		:=
AllPrograms		:=

IncDir			:= $(BaseDir)include
LibDir			:= $(BaseDir)lib

# It's a good idea to never create directories in recipes since
# that can lead to a race condition under -j. This method is
# guaranteed to be single-threaded and to run before recipes.
$(shell [ -d $(LibDir) ] || set -x; mkdir -p $(LibDir))

CFLAGS			:= -W
DFLAGS			:=
IFLAGS			:= -I$(IncDir)
_cflags			:= $(CFLAGS) $(DFLAGS) $(IFLAGS)

LDFLAGS			:=

CC			:= gcc

a			:= a
d			:= d
o			:= o

###############################################################
# Generates rules for static libraries, aka archive libraries.
# Also generates a phony rule using the basename of the target.
###############################################################
define _ArchiveRule =
.PHONY: $(notdir $(1))
$(notdir $(1)): $(LibDir)/$(notdir $(1)).$a
$(LibDir)/$(notdir $(1)).$a: $$($(1)_objs)
	$$(strip $$(subst $$(BaseDir),$$$${BASE},cd $$(<D) &&\
	$(RM) $$@ &&\
	$(AR) -cr $$@ $$(^F)))
IntermediateTargets	+= $$($(1)_objs)
FinalTargets		+= $(LibDir)/$(notdir $(1)).$a
PrereqFiles		+= $$(addsuffix .$d,$$($(1)_objs))
endef

###############################################################
# Generates rules for binary executable programs.
# Also generates a phony rule using the basename of the target.
###############################################################
define _ProgramRule =
.PHONY: $(notdir $(1))
$(notdir $(1)): $(1)
ifeq (,$$($(1)_libs))
$(1): $$($(1)_objs)
else
$(1): $$($(1)_objs) $(addprefix $(LibDir)/,$$($(1)_libs))
endif
	$$(strip $$(subst $$(BaseDir),$$$${BASE},\
	cd $$(@D) &&\
	$(CC) -o $$(@F) $(LDFLAGS) $$^))
IntermediateTargets	+= $$($(1)_objs)
FinalTargets		+= $(1)
PrereqFiles		+= $$(addsuffix .$d,$$($(1)_objs))
endef

endif #VARS_
