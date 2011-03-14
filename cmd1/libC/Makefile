# Copyright (c) 2002-2011 David Boyce.  All rights reserved.

mfd := $(dir $(realpath $(lastword ${MAKEFILE_LIST})))
ifndef BaseDir
include $(realpath $(mfd)../..)/Makefile
else
###################### IGNORE ABOVE ###############################

AllArchives		+= $(mfd)libC
$(mfd)libC_objs		:= $(mfd)c1.$o $(mfd)c2.$o $(mfd)c3.$o

###################### IGNORE BELOW ###############################
endif
