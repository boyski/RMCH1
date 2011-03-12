ifndef FOOTER_
FOOTER_ := 1

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

# Now that lists of required targets have been established, eval the
# rule generators with that context.

$(foreach _tgt,$(AllArchives),$(eval $(call _ArchiveRule,$(_tgt))))

$(foreach _tgt,$(AllPrograms),$(eval $(call _ProgramRule,$(_tgt))))

# Establish key dependencies.
all: $(filter $(TgtFilter)%, $(FinalTargets))

# Pick up all generated dependency information.
-include $(sort $(PrereqFiles))

# Conventional "clean" target - removes all known, existing target files.
_targets := $(FinalTargets) $(IntermediateTargets) $(PrereqFiles)
_reltgts := $(patsubst $(BaseDir)%,%,$(wildcard $(_targets)))
.PHONY: clean
ifneq (,$(_reltgts))
clean: ; cd $(BaseDir) && rm -f $(_reltgts)
else
clean: ; @echo "Already clean!"
endif

# Cleans not only official targets but also any typical target types
# (files ending with the extensions listed below) which may not be
# mentioned as a target.
_exts := *.$a *.$d *.$o
_dirs := $(sort $(dir $(realpath ${MAKEFILE_LIST}))) $(BaseDir)lib/
.PHONY: realclean
realclean:
	cd $(BaseDir) && rm -f $(patsubst $(BaseDir)%,%,$(sort $(wildcard $(_targets) $(foreach _dir,$(_dirs),$(addprefix $(_dir),$(_exts))))))

.PHONY: help
help:
	@cat $(BaseDir)README

# Causes only targets defined within the current subtree (and their prerequisites)
# to be considered for build purposes.
.PHONY: subtree
subtree:
	$(MAKE) --no-print-directory -f $(firstword $(MAKEFILE_LIST)) TgtFilter=$(CURDIR)/

.SECONDEXPANSION:

# Support both traditional ("gcc -c -MD ...") and AO ("ao -MD make ...")
# methods of dependency generation.
# See http://audited-objects.sourceforge.net for the former and
# http://gcc.gnu.org/onlinedocs/gcc-4.3.5/gcc/Preprocessor-Options.html#Preprocessor-Options
# for the latter.
# The non-AO case implements a pattern adapted from the
# Linux kernel designed to trigger rebuilds on recipe changes.
ifdef AO_BASE_DIR
%.$o: %.c
	$(strip $(subst $(BaseDir),$${BASE},$(CC) -c -o $@ $(_cflags) $<))
else
.PHONY: _FORCE
%.$o: _cmd = $(strip $(subst $(BaseDir),$${BASE},$(CC) -c -o $@ -MD -MF $@.$d $(_cflags) $(@:.$o=.c)))
%.$o: %.c $$(if $$(filter $$(CMD_$$(subst $$(BaseDir),,$$@)),$$(subst $$(Space),_,$$(_cmd))),,_FORCE)
	$(_cmd)
	@echo 'CMD_$(subst $(BaseDir),,$@) := $(subst $(Space),_,$(subst $$,$$$$,$(_cmd)))' >> $@.$d
endif

endif #FOOTER_
