# Copyright (c) 2002-2011 David Boyce.  All rights reserved.
mfd := $(dir $(realpath $(lastword ${MAKEFILE_LIST})))
ifndef BaseDir
include $(realpath $(mfd)..)/Makefile
else
###################### IGNORE ABOVE ###############################

AllPrograms		+= $(mfd)cmd2
$(mfd)cmd2_objs		:= $(mfd)main.$o
$(mfd)cmd2_libs		:= libA.$a libB.$a

###################### IGNORE BELOW ###############################
endif
