# Copyright (c) 2002-2011 David Boyce.  All rights reserved.

mfd := $(dir $(realpath $(lastword ${MAKEFILE_LIST})))
ifndef BaseDir
include $(realpath $(mfd)..)/Makefile
else
###################### IGNORE ABOVE ###############################

AllArchives		+= $(mfd)libA
$(mfd)libA_objs		:= $(mfd)a1.$o $(mfd)a2.$o

###################### IGNORE BELOW ###############################
endif
