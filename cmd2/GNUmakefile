# Copyright (c) 2002-2011 David Boyce.  All rights reserved.
mfd := $(dir $(realpath $(lastword ${MAKEFILE_LIST})))
ifndef SrcBase
include $(mfd)../GNUmakefile
else
$(call InitDir,$(mfd))
###################### IGNORE ABOVE ###############################

AllPrograms		+= $(td)cmd2
$(td)cmd2_objs		:= $(td)main.$o
$(td)cmd2_libs		:= libA.$a libB.$a

###################### IGNORE BELOW ###############################
endif
