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

$(foreach _tgt,$(ALL_ARCHIVES),$(eval $(call ARCHIVE_RULE,$(_tgt))))

$(foreach _tgt,$(ALL_PROGRAMS),$(eval $(call PROGRAM_RULE,$(_tgt))))

# Establish the key dependencies.
all: $(TERMINAL_TARGETS)

# Conventional targets.

clean:
	rm -f $(TERMINAL_TARGETS) $(INTERMEDIATE_TARGETS)

endif #FOOTER_
