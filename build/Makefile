BDFTOPCF ?= bdftopcf

BDFTOPCF_TERMINAL_FONT = -t

monospace = aqui drift edges fkp kates lime smoothansi
monospace := $(monospace:%=%.bdf) $(monospace:%=%-bold.bdf)


VPATH = ..
#vpath %.bdf ..

outputs := $(notdir $(patsubst %.bdf,%.pcf,$(wildcard ../*.bdf)))


%.pcf : %.bdf
	$(BDFTOPCF) $(if $(findstring $(notdir $<),$(monospace)),$(BDFTOPCF_TERMINAL_FONT)) -o $@ $<

.PHONY: all clean

all: $(outputs)

clean:
	rm *.pcf
