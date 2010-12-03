ifndef RULES_
RULES_ := 1

# Generates rules for static libraries, aka archive libraries.
define ARCHIVE_RULE =
$(1).$a: $$($(1)_OBJS)
	cd $$(@D) &&\
	$(RM) $$(@F) &&\
	$(AR) -cr $$(@F) $$(notdir $$^)
INTERMEDIATE_TARGETS	+= $$($(1)_OBJS)
TERMINAL_TARGETS	+= $(1).$a
LIBPATHS		:= $$(sort $$(LIBPATHS) $$(@D))
endef

# Generates rules for binary executable programs.
define PROGRAM_RULE =
$(1): $$($(1)_OBJS) ## $$($(1)_LIBS:%=-l%)
	cd $$(@D) &&\
	$(CC) $(LDFLAGS) -o $$(@F) $$(notdir $$^)
INTERMEDIATE_TARGETS	+= $$($(1)_OBJS)
TERMINAL_TARGETS	+= $(1)
endef

endif #RULES_
