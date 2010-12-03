# Determine the root of the build tree.
export BASE := $(dir $(abspath $(lastword ${MAKEFILE_LIST})))

# Reserve 'all' as the default target.
.PHONY: all
all:

# Early infrastructure.
include $(BASE)/Vars.mk
include $(BASE)/Rules.mk

# Subdir makefiles.
include $(BASE)libA/Makefile
include $(BASE)libB/Makefile
include $(BASE)cmd1/Makefile

# Late infrastructure.
include $(BASE)Footer.mk
