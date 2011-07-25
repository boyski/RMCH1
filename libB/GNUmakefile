# Copyright (c) 2002-2011 David Boyce.  All rights reserved.
mfd := $(dir $(realpath $(lastword ${MAKEFILE_LIST})))
ifndef SrcBase
include $(mfd)../GNUmakefile
else
$(call InitDir,$(mfd))
###################### IGNORE ABOVE ###############################

AllArchives		+= $(td)libB
$(td)libB_objs		:= $(td)b1.$o $(td)b2.$o

###################### IGNORE BELOW ###############################
endif
