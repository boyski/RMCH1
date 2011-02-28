ifndef RULES_
RULES_ := 1

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

.SUFFIXES:

vpath %.$a $(LibDir)

%.o: %.c
	$(strip $(CC) -c -o $@ -MMD -I$(IncDir) $<)

###############################################################
# Generates rules for static libraries, aka archive libraries.
# Also generates a phony rule using the basename of the target.
###############################################################
define _ArchiveRule =
.PHONY: $(notdir $(1))
$(notdir $(1)): $(LibDir)/$(notdir $(1)).$a
$(LibDir)/$(notdir $(1)).$a: $$($(1)_objs)
	$$(strip cd $$(<D) &&\
	$(RM) $$@ &&\
	$(AR) -cr $$@ $$(^F))
PrereqFiles		+= $$(patsubst %.o,%.d,$$($(1)_objs))
IntermediateTargets	+= $$($(1)_objs)
FinalTargets		+= $(LibDir)/$(notdir $(1)).$a
endef

###############################################################
# Generates rules for binary executable programs.
# Also generates a phony rule using the basename of the target.
###############################################################
define _ProgramRule =
.PHONY: $(notdir $(1))
$(notdir $(1)): $(1)
$(1): $$($(1)_objs) $(addprefix $(LibDir)/,$$($(1)_libs))
	$$(strip cd $$(@D) &&\
	$(CC) -o $$(@F) $(LDFLAGS) $$^)
PrereqFiles		+= $$(patsubst %.o,%.d,$$($(1)_objs))
IntermediateTargets	+= $$($(1)_objs)
FinalTargets		+= $(1)
endef

endif #RULES_
