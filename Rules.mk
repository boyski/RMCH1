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

# Support both traditional ("gcc -MD") and AO ("ao -MD run make ...") ways
# of dependency generation. See http://audited-objects.sourceforge.net
# for the latter.
ifdef AO_BASE_DIR
%.$o: %.c
	$(strip $(subst $(BaseDir),$${BASE}, $(CC) -c -o $@ -I$(IncDir) $<))
else
%.$o: %.c
	$(strip $(subst $(BaseDir),$${BASE}, $(CC) -c -o $@ -MD -MF $@.$d -I$(IncDir) $<))
endif

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

endif #RULES_
