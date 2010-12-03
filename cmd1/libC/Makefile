mfd := $(dir $(abspath $(lastword ${MAKEFILE_LIST})))
ifndef BASE
include $(realpath $(mfd)../..)/Makefile
else
###################### IGNORE ABOVE ###############################

ALL_ARCHIVES		+= $(mfd)libC
$(mfd)libC_OBJS		:= $(mfd)c1.$o $(mfd)c2.$o $(mfd)c3.$o

###################### IGNORE BELOW ###############################
endif
