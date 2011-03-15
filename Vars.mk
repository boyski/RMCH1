ifndef VARS_
VARS_ := 1

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

IncDir			:= $(SrcBase)include
LibDir			:= $(TgtBase)lib/

CFLAGS			:= -W
DFLAGS			:=
IFLAGS			:= -I$(IncDir)
_cflags			:= $(CFLAGS) $(DFLAGS) $(IFLAGS)

LDFLAGS			:=

CC			:= gcc

a			:= a
d			:= d
o			:= o

# Extensible initialization call from sub-makefiles.
InitDir			= $(eval td := $(subst $(SrcBase),$(TgtBase),$(1)))

###############################################################
# Generate rules for static libraries, aka archive libraries.
# Also generates a phony rule using the basename of the target.
# And makes an order-only dependency on the target's directory.
###############################################################
define _ArchiveRule
.PHONY: $(notdir $(1))
$(notdir $(1)): $(LibDir)$(notdir $(1)).$a
$$($(1)_objs): | $$(sort $$(dir $$($(1)_objs)))
$(LibDir)$(notdir $(1)).$a: $$($(1)_objs) | $(LibDir)
	$$(strip $$(subst $$(SrcBase),$$$${BASE},cd $$(<D) &&\
	$(RM) $$@ &&\
	$(AR) -cr $$@ $$(^F)))
IntermediateTargets	+= $$($(1)_objs)
FinalTargets		+= $(LibDir)$(notdir $(1)).$a
PrereqFiles		+= $$(addsuffix .$d,$$($(1)_objs))
endef

###############################################################
# Generates rules for binary executable programs.
# Also generates a phony rule using the basename of the target.
# And makes an order-only dependency on the target's directory.
###############################################################
define _ProgramRule
.PHONY: $(notdir $(1))
$(notdir $(1)): $(1)
$$($(1)_objs): | $$(sort $$(dir $$($(1)_objs)))
ifeq (,$$($(1)_libs))
$(1): $$($(1)_objs)
else
$(1): $$($(1)_objs) $(addprefix $(LibDir),$$($(1)_libs))
endif
	$$(strip $$(subst $$(SrcBase),$$$${BASE},\
	cd $$(@D) &&\
	$(CC) -o $$(@F) $(LDFLAGS) $$^))
IntermediateTargets	+= $$($(1)_objs)
FinalTargets		+= $(1)
PrereqFiles		+= $$(addsuffix .$d,$$($(1)_objs))
endef

endif #VARS_
