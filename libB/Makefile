# Copyright (c) 2002-2011 David Boyce.  All rights reserved.
mfd := $(dir $(realpath $(lastword ${MAKEFILE_LIST})))
ifndef BaseDir
include $(realpath $(mfd)..)/Makefile
else
###################### IGNORE ABOVE ###############################

AllArchives		+= $(mfd)libB
$(mfd)libB_objs		:= $(mfd)b1.$o $(mfd)b2.$o

###################### IGNORE BELOW ###############################
endif
