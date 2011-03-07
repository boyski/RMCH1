# Copyright (c) 2002-2010 David Boyce.  All rights reserved.

mfd := $(dir $(realpath $(lastword ${MAKEFILE_LIST})))
ifndef BaseDir
include $(realpath $(mfd)..)/Makefile
else
###################### IGNORE ABOVE ###############################

AllPrograms		+= $(mfd)cmd3
$(mfd)cmd3_objs		:= $(mfd)main.$o

###################### IGNORE BELOW ###############################
endif
