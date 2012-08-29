OUTDIR ?= ./build
BDFTOPCF ?= bdftopcf

BDFTOPCF_TERMINAL_FONT = -t

monospace = aqui drift edges fkp kates lime smoothansi
monospace := $(monospace:%=%.bdf) $(monospace:%=%-bold.bdf)


VPATH = ..
#vpath %.bdf ..

outputs := $(patsubst %.bdf,$(OUTDIR)/%.pcf,$(wildcard *.bdf))


.PHONY: all clean

all: $(outputs)

clean:
	rm $(outputs)

distclean:
	rm -r $(OUTDIR)


$(OUTDIR):
	mkdir -p $@

$(OUTDIR)/%.pcf: %.bdf $(OUTDIR)
	$(BDFTOPCF) $(if $(findstring $(notdir $<),$(monospace)),$(BDFTOPCF_TERMINAL_FONT)) -o $@ $<
