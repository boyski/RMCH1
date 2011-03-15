# Copyright (c) 2002-2011 David Boyce.  All rights reserved.
mfd := $(dir $(realpath $(lastword ${MAKEFILE_LIST})))
ifndef SrcBase
include $(realpath $(mfd)..)/Makefile
else
$(call InitDir,$(mfd))
###################### IGNORE ABOVE ###############################

AllPrograms		+= $(td)cmd1
$(td)cmd1_objs		:= $(td)main.$o
$(td)cmd1_libs		:= libA.$a libB.$a libC.$a

###################### IGNORE BELOW ###############################
endif
