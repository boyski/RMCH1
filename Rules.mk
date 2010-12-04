ifndef RULES_
RULES_ := 1

.SUFFIXES:

vpath %.$a $(LIBDIR)

%.o: %.c
	$(COMPILE.c) $(OUTPUT_OPTION) $<

# Generates rules for static libraries, aka archive libraries.
define ARCHIVE_RULE =
$(1).$a: $$($(1)_OBJS)
	cd $$(@D) &&\
	$(RM) $$(@F) &&\
	$(AR) -cr $$(@F) $$(notdir $$^)
$(LIBDIR)/$(notdir $(1)).$a: $(1).$a
	$(RM) $$@ &&\
	mkdir -p $$(@D) &&\
	cp -p $$^ $$(@D)
INTERMEDIATE_TARGETS	+= $$($(1)_OBJS) $$@
TERMINAL_TARGETS	+= $(LIBDIR)/$(notdir $(1)).$a
endef

# Generates rules for binary executable programs.
define PROGRAM_RULE =
$(1): $$($(1)_OBJS) $$($(1)_LIBS:%=-l%)
	cd $$(@D) &&\
	$(CC) -o $$(@F) $(LDFLAGS) $$(notdir $$^)
INTERMEDIATE_TARGETS	+= $$($(1)_OBJS)
TERMINAL_TARGETS	+= $(1)
endef

endif #RULES_
