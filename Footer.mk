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

# Conventional targets.

.PHONY: clean
clean:
	cd $(Base) && rm -f $(patsubst $(Base)%,%,$(wildcard $(FinalTargets) $(IntermediateTargets) $(PrereqFiles)))

.PHONY: help
help:
	@cat $(Base)README

# Causes only targets defined within the current subtree (and their prerequisites)
# to be considered.
.PHONY: subtree
subtree:
	$(MAKE) --no-print-directory -f $(firstword $(MAKEFILE_LIST)) TgtFilter=$(CURDIR)/

endif #FOOTER_
