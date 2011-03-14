# Copyright (c) 2002-2011 David Boyce.  All rights reserved.
mfd := $(dir $(realpath $(lastword ${MAKEFILE_LIST})))
ifndef BaseDir
include $(realpath $(mfd)..)/Makefile
else
###################### IGNORE ABOVE ###############################

AllPrograms		+= $(mfd)cmd1
$(mfd)cmd1_objs		:= $(mfd)main.$o
$(mfd)cmd1_libs		:= libA.$a libB.$a libC.$a

# Includes must be at the bottom.
include $(mfd)libC/Makefile

###################### IGNORE BELOW ###############################
endif
