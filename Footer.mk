ifndef FOOTER_
FOOTER_ := 1

$(foreach _tgt,$(ALL_ARCHIVES),$(eval $(call ARCHIVE_RULE,$(_tgt))))

$(foreach _tgt,$(ALL_PROGRAMS),$(eval $(call PROGRAM_RULE,$(_tgt))))

# Establish the key dependencies.
all: $(TERMINAL_TARGETS)

# Conventional targets.

clean:
	rm -f $(TERMINAL_TARGETS) $(INTERMEDIATE_TARGETS)

endif #FOOTER_
