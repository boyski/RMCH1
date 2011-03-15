# Copyright (c) 2002-2011 David Boyce.  All rights reserved.
mfd := $(dir $(realpath $(lastword ${MAKEFILE_LIST})))
ifndef SrcBase
include $(realpath $(mfd)..)/Makefile
else
$(call InitDir,$(mfd))
###################### IGNORE ABOVE ###############################

AllArchives		+= $(td)libA
$(td)libA_objs		:= $(td)a1.$o $(td)a2.$o

###################### IGNORE BELOW ###############################
endif
