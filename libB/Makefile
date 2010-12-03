mfd := $(dir $(abspath $(lastword ${MAKEFILE_LIST})))
ifndef BASE
include $(realpath $(mfd)..)/Makefile
else
###################### IGNORE ABOVE ###############################

ALL_ARCHIVES		+= $(mfd)libB
$(mfd)libB_OBJS		:= $(mfd)b1.$o $(mfd)b2.$o

###################### IGNORE BELOW ###############################
endif
