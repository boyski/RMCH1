# Copyright (c) 2002-2011 David Boyce.  All rights reserved.
mfd := $(dir $(realpath $(lastword ${MAKEFILE_LIST})))
ifndef SrcBase
include $(mfd)../Makefile
else
$(call InitDir,$(mfd))
###################### IGNORE ABOVE ###############################

AllArchives		+= $(td)libC
$(td)libC_objs		:= $(td)c1.$o $(td)c2.$o $(td)c3.$o

###################### IGNORE BELOW ###############################
endif
