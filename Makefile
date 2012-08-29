OUTDIR ?= ./build
BDFTOPCF ?= bdftopcf

BDFTOPCF_TERMINAL_FONT = -t

monospace = aqui drift edges fkp kates lime smoothansi
monospace := $(monospace:%=%.bdf) $(monospace:%=%-bold.bdf)


VPATH = ..
#vpath %.bdf ..

font_outputs := $(patsubst %.bdf,$(OUTDIR)/%.pcf,$(wildcard *.bdf))
fontdir_outputs := fonts.alias fonts.dir fonts.scale
fontdir_outputs := $(patsubst %,$(OUTDIR)/%,$(fontdir_outputs))
outputs := $(font_outputs) $(fontdir_outputs)


.PHONY: all clean

all: $(outputs)

clean:
	rm -f $(outputs)

distclean:
	rm -r $(OUTDIR)


$(OUTDIR)/fonts.alias: fonts.alias
	cp $< $@

$(OUTDIR)/fonts.scale: $(OUTDIR)/fonts.alias
	mkfontscale $(OUTDIR)

$(OUTDIR)/fonts.dir: $(OUTDIR)/fonts.alias $(OUTDIR)/fonts.scale
	mkfontdir $(OUTDIR)

$(OUTDIR):
	mkdir -p $@

$(OUTDIR)/%.pcf: %.bdf $(OUTDIR)
	$(BDFTOPCF) $(if $(findstring $(notdir $<),$(monospace)),$(BDFTOPCF_TERMINAL_FONT)) -o $@ $<
