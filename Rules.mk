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

vpath %.$a $(LIBDIR)

%.o: %.c
	$(COMPILE.c) $(OUTPUT_OPTION) $<

# Generates rules for static libraries, aka archive libraries.
define ARCHIVE_RULE =
$(1).$a: $$($(1)_OBJS)
	cd $$(@D) &&\
	$(RM) $$(@F) &&\
	$(AR) -cr $$(@F) $$(notdir $$^)
$(LIBDIR)/$(notdir $(1)).$a: $(1).$a
	$(RM) $$@ &&\
	mkdir -p $$(@D) &&\
	cp -p $$^ $$(@D)
INTERMEDIATE_TARGETS	+= $$($(1)_OBJS) $$@
TERMINAL_TARGETS	+= $(LIBDIR)/$(notdir $(1)).$a
endef

# Generates rules for binary executable programs.
define PROGRAM_RULE =
$(1): $$($(1)_OBJS) $(addprefix $(LIBDIR)/,$$($(1)_LIBS))
	cd $$(@D) &&\
	$(CC) -o $$(@F) $(LDFLAGS) $$^
INTERMEDIATE_TARGETS	+= $$($(1)_OBJS)
TERMINAL_TARGETS	+= $(1)
endef

endif #RULES_
