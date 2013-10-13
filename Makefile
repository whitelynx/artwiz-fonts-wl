OUTDIR ?= ./build

DESTDIR ?= /
SYSCONFDIR ?= /etc
XORGCONFDIR ?= $(SYSCONFDIR)/X11/xorg.conf.d
PREFIX ?= /usr
FONTDIR ?= $(PREFIX)/share/fonts
TARGET ?= $(FONTDIR)/artwiz-fonts-wl

BDFTOPCF ?= bdftopcf
BDFTOPCF_TERMINAL_FONT = -t

monospace = aqui drift edges fkp kates lime smoothansi
monospace := $(monospace:%=%.bdf) $(monospace:%=%-bold.bdf)


VPATH = ..
#vpath %.bdf ..

font_outputs := $(patsubst %.bdf,$(OUTDIR)/%.pcf,$(wildcard *.bdf))
fontdir_outputs := fonts.alias fonts.dir fonts.scale
fontdir_outputs := $(patsubst %,$(OUTDIR)/%,$(fontdir_outputs))
outputs := $(font_outputs) $(fontdir_outputs) $(OUTDIR)/x-fonts.conf


.PHONY: all clean distclean install

all: $(outputs)

clean:
	rm -f $(outputs)

distclean:
	rm -r $(OUTDIR)

install: $(outputs)
	install -m755 -d $(DESTDIR)/$(XORGCONFDIR)
	install -m644 $(OUTDIR)/x-fonts.conf $(DESTDIR)/$(XORGCONFDIR)/40-x-fonts.conf
	install -m755 -d $(DESTDIR)/$(TARGET)
	install -m644 -t $(DESTDIR)/$(TARGET) $(outputs)


$(OUTDIR)/fonts.alias: fonts.alias
	cp $< $@

$(OUTDIR)/fonts.scale: $(OUTDIR)/fonts.alias
	mkfontscale $(OUTDIR)

$(OUTDIR)/fonts.dir: $(OUTDIR)/fonts.alias $(OUTDIR)/fonts.scale
	mkfontdir $(OUTDIR)

$(OUTDIR)/x-fonts.conf: templates/x-fonts.conf
	sed 's@%(TARGET)@'$(TARGET)'@g' $< > $@

$(OUTDIR):
	mkdir -p $@

$(OUTDIR)/%.pcf: %.bdf $(OUTDIR)
	$(BDFTOPCF) $(if $(findstring $(notdir $<),$(monospace)),$(BDFTOPCF_TERMINAL_FONT)) -o $@ $<
