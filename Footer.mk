ifndef FOOTER_
FOOTER_ := 1

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

# Now that lists of required targets have been established, eval the
# rule generators with that context.

$(foreach _tgt,$(AllArchives),$(eval $(call _ArchiveRule,$(_tgt))))

$(foreach _tgt,$(AllPrograms),$(eval $(call _ProgramRule,$(_tgt))))

# Establish key dependencies.
all: $(filter $(TgtFilter)%, $(FinalTargets))

# Pick up all generated dependency information.
-include $(sort $(PrereqFiles))

# The complete list of all known targets.
_targets := $(FinalTargets) $(IntermediateTargets) $(PrereqFiles)

# Directories for targets may need to be created on the fly
# (via order-only dependencies and in a thread-safe way).
# Directories must be created only in a discrete recipe like
# this because creating them on demand as part of a bigger recipe
# causes a race condition in parallel builds.
_tgtdirs := $(sort $(dir $(_targets)))
$(_tgtdirs):
	mkdir -p $@

# Conventional "clean" target - removes all known, existing target files.
_reltgts := $(patsubst $(TgtBase)%,%,$(wildcard $(_targets)))
.PHONY: clean
ifneq (,$(_reltgts))
clean: ; cd $(TgtBase) && $(RM) $(_reltgts)
else
clean: ; @echo "Already clean!"
endif

# Cleans not only official targets but also any typical target types
# (files ending with the extensions listed below) which may not be
# mentioned as a target.
_exts := *.$a *.$d *.$o
_dirs := $(sort $(dir $(realpath ${MAKEFILE_LIST}))) $(TgtBase)lib$/
.PHONY: realclean
realclean:
ifeq ($(SrcBase),$(TgtBase))
	cd $(TgtBase) && $(RM) $(patsubst $(TgtBase)%,%,$(sort $(wildcard $(_targets) $(foreach _dir,$(_dirs),$(addprefix $(_dir),$(_exts))))))
else
	$(RM) -r $(TgtBase)
endif

.PHONY: help
help:
	@cat $(SrcBase)README

# Causes only targets defined within the current subtree (and their prerequisites)
# to be considered for build purposes.
.PHONY: subtree
subtree:
	$(MAKE) --no-print-directory -f $(firstword $(MAKEFILE_LIST)) TgtFilter=$(CURDIR)$/

.SECONDEXPANSION:

# The following supports the traditional gcc -MD flags for dependency generation
# during C compilation steps. It also implements a pattern adapted from the
# Linux kernel designed to trigger rebuilds on recipe changes.
# See http://make.mad-scientist.us/autodep.html and
# http://gcc.gnu.org/onlinedocs/gcc-4.3.5/gcc/Preprocessor-Options.html#Preprocessor-Options
# for details on the former and a modern Linux kernel tree for the latter.

.PHONY: RECIPE_CHANGED
$(TgtBase)%.$o: _cmd = $(strip $(subst $(SrcBase),$${SBASE},$(CC) $(cf) $(of)$@ -MD -MF $@.$d $(_cflags) $(subst $(TgtBase),$(SrcBase),$(@:.$o=.c))))
$(TgtBase)%.$o: $(SrcBase)%.c
$(TgtBase)%.$o: $$(if $$(filter $$(Recipe_$$(subst $$(TgtBase),,$$@)),$$(subst $$(Space),_,$$(_cmd))),,RECIPE_CHANGED)
	$(_cmd)
	@echo Recipe_$(subst $(TgtBase),,$@) := '$(subst $(Space),_,$(subst $$,$$$$,$(_cmd)))' >> $@.$d

endif #FOOTER_
