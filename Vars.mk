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
LibDir			:= $(TgtBase)lib$/

PERL			:= perl

ifdef VSINSTALLDIR
CC			:= $(PERL) -w $(SrcBase)/Bin/clw.pl
CFLAGS			:= -W3
DFLAGS			:=
IFLAGS			:= -I$(IncDir)
_cflags			:= $(CFLAGS) $(DFLAGS) $(IFLAGS)
LDFLAGS			:= /nologo
AR			:= ar
ARFLAGS			:= -cr
cf			:= -c
of			:= -Fo
o			:= obj
a			:= lib
d			:= d
MV			:= move /Y
else	#VSINSTALLDIR
CC			:= gcc
CFLAGS			:= -W
DFLAGS			:=
IFLAGS			:= -I$(IncDir)
_cflags			:= $(CFLAGS) $(DFLAGS) $(IFLAGS)
LDFLAGS			:=
AR			:= ar
ARFLAGS			:= -cr
cf			:= -c
of			:= -o
o			:= o
a			:= a
d			:= d
MV			:= mv -f

# Verbosity hack - assumes Bourne-compatible shell. Turns off regular
# make verbosity, turns on shell verbosity with -x flag. Note that
# this type of verbosity goes to stderr.
ifdef V
ifneq (0,$V)
.SILENT:
#SHELL			:= /bin/bash
SHELL_ORIG		:= $(SHELL)
SHELL			 = $(warning [$@])$(SHELL_ORIG) -x
endif	## V != 0
endif	## V

endif	## VSINSTALLDIR

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
	$$(strip $$(subst $$(SrcBase),$$$${SBASE},\
	cd $$(<D) &&\
	$(AR) $(ARFLAGS) $$@ $$(^F)))
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
$(1): $$($(1)_objs) $$(if $$($(1)_libs),$$(addprefix $(LibDir),$$($(1)_libs)))
	$$(strip $$(subst $$(SrcBase),$$$${SBASE},\
	cd $$(@D) &&\
	$$(subst $$(@D)/,,$(CC) $(of)$$(@F) $(LDFLAGS) $$^)))
IntermediateTargets	+= $$($(1)_objs)
FinalTargets		+= $(1)
PrereqFiles		+= $$(addsuffix .$d,$$($(1)_objs))
endef

endif ## VARS_
