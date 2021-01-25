OUTDIR ?= ./build

DESTDIR ?= /
SYSCONFDIR ?= /etc
XORGCONFDIR ?= $(SYSCONFDIR)/X11/xorg.conf.d
PREFIX ?= /usr
FONTDIR ?= $(PREFIX)/share/fonts
TARGET ?= $(FONTDIR)/artwiz-fonts-wl
USER_FONTDIR ?= $(HOME)/.fonts
USER_TARGET ?= $(USER_FONTDIR)/artwiz-fonts-wl

BDFTOPCF ?= bdftopcf
BDFTOPCF_TERMINAL_FONT = -t

FONTFORGE ?= fontforge

monospace = aqui drift edges fkp kates lime smoothansi
monospace := $(monospace:%=%.bdf) $(monospace:%=%-bold.bdf)


VPATH = ..
#vpath %.bdf ..

pcf_font_outputs := $(patsubst %.bdf,$(OUTDIR)/%.pcf,$(wildcard *.bdf))
pcf_fontdir_outputs := fonts.alias fonts.dir fonts.scale
pcf_fontdir_outputs := $(patsubst %,$(OUTDIR)/%,$(pcf_fontdir_outputs))
pcf_outputs := $(pcf_font_outputs) $(pcf_fontdir_outputs) $(OUTDIR)/x11-artwiz-fonts-wl.conf

otf_font_outputs := $(patsubst %.bdf,$(OUTDIR)/%.otf,$(filter-out %-bold.bdf,$(wildcard *.bdf)))
otf_fontdir_outputs := fonts.alias fonts.dir fonts.scale
otf_fontdir_outputs := $(patsubst %,$(OUTDIR)/%,$(otf_fontdir_outputs))
otf_outputs := $(otf_font_outputs) $(otf_fontdir_outputs)


.PHONY: all pcf otf clean distclean install-pcf install-otf

all: pcf otf
pcf: $(pcf_outputs)
otf: $(otf_outputs)

clean:
	rm -f $(pcf_outputs) $(otf_outputs)

distclean:
	rm -r $(OUTDIR)


install: install-pcf install-otf build-fontconfig-system-cache

install-user: install-otf-user build-fontconfig-user-cache

install-pcf: $(pcf_outputs)
	install -m755 -d $(DESTDIR)/$(XORGCONFDIR)
	install -m644 $(OUTDIR)/x11-artwiz-fonts-wl.conf $(DESTDIR)/$(XORGCONFDIR)/40-artwiz-fonts-wl.conf
	install -m755 -d $(DESTDIR)/$(TARGET)
	install -m644 -t $(DESTDIR)/$(TARGET) $(pcf_font_outputs) $(pcf_fontdir_outputs)

install-otf: $(otf_outputs)
	install -m755 -d $(DESTDIR)/$(TARGET)
	install -m644 -t $(DESTDIR)/$(TARGET) $(otf_font_outputs) $(otf_fontdir_outputs)

install-otf-user: $(otf_outputs)
	install -m755 -d $(USER_TARGET)
	install -m644 -t $(USER_TARGET) $(otf_font_outputs) $(otf_fontdir_outputs)

build-fontconfig-user-cache:
	fc-cache -f

build-fontconfig-system-cache:
	fc-cache -fs


$(OUTDIR)/fonts.alias: fonts.alias
	cp $< $@

$(OUTDIR)/fonts.scale: $(OUTDIR)/fonts.alias
	mkfontscale $(OUTDIR)

$(OUTDIR)/fonts.dir: $(OUTDIR)/fonts.alias $(OUTDIR)/fonts.scale
	mkfontdir $(OUTDIR)

$(OUTDIR)/x11-artwiz-fonts-wl.conf: templates/x11-artwiz-fonts-wl.conf
	sed 's@%(TARGET)@'$(TARGET)'@g' $< > $@

$(OUTDIR):
	mkdir -p $@

$(OUTDIR)/%.pcf: %.bdf $(OUTDIR)
	$(BDFTOPCF) $(if $(findstring $(notdir $<),$(monospace)),$(BDFTOPCF_TERMINAL_FONT)) -o $@ $<

$(OUTDIR)/%.otf: %.bdf
	$(FONTFORGE) -script scripts/fontforge-convert.pe $< $@
