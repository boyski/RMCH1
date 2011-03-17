# Copyright (c) 2002-2011 David Boyce.  All rights reserved.
mfd := $(dir $(realpath $(lastword ${MAKEFILE_LIST})))
ifndef SrcBase
include $(mfd)../Makefile
else
$(call InitDir,$(mfd))
###################### IGNORE ABOVE ###############################

AllPrograms		+= $(td)cmd3
$(td)cmd3_objs		:= $(td)main.$o

###################### IGNORE BELOW ###############################
endif
