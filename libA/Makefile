mfd := $(dir $(abspath $(lastword ${MAKEFILE_LIST})))
ifndef BASE
include $(realpath $(mfd)..)/Makefile
else
###################### IGNORE ABOVE ###############################

ALL_ARCHIVES		+= $(mfd)libA
$(mfd)libA_OBJS		:= $(mfd)a1.$o $(mfd)a2.$o

###################### IGNORE BELOW ###############################
endif
