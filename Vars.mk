ifndef VARS_
VARS_ := 1

# Initialize general purpose make variables. This is where the
# decision about simply- vs recursively-expanded is made, because
# the += operator respects the previous state but defaults to
# recursive. Therefore, if a variable should be simply-expanded
# it's a good idea to initialize it so here.

INTERMEDIATE_TARGETS	:=
TERMINAL_TARGETS	:=

ALL_ARCHIVES		:=
ALL_PROGRAMS		:=

INCDIR			:= $(BASE)include
LIBDIR			:= $(BASE)lib

CFLAGS			+= -I$(INCDIR)
LDFLAGS			+=

CC			:= gcc

a			:= a
o			:= o

endif #VARS_
