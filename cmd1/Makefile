mfd := $(dir $(abspath $(lastword ${MAKEFILE_LIST})))
ifndef BASE
include $(realpath $(mfd)..)/Makefile
else
###################### IGNORE ABOVE ###############################

ALL_PROGRAMS		+= $(mfd)cmd1
$(mfd)cmd1_OBJS		:= $(mfd)main.$o
$(mfd)cmd1_LIBS		:= libA libB libC

# Includes must be at the bottom.
include $(mfd)libC/Makefile

###################### IGNORE BELOW ###############################
endif
