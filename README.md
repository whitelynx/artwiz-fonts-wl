Description
-----------

A set of modified [artwiz fonts][] ([original site][]) based on [artwiz-aleczapka][] and [artwiz-latin1][], with:

 * Full [ISO/IEC 8859-1][] support (German, Portuguese, Swedish etc. characters; equivalent to the [Basic Latin][] and
    [Latin-1 Supplement][] blocks of [Unicode][])
 * Glyph names matching standard Unicode character names, 
 * A bold variant of each font. (based on artwiz-latin1's bold fonts, but with some fixes; most notably, font bounding
    box corrections)

[artwiz fonts]: https://web.archive.org/web/20201021124738/https://en.wikipedia.org/wiki/Artwiz_fonts
[original site]: https://web.archive.org/web/20011215030159/http://artwiz.artramp.org/index.phtml?section=files&browse=fonts
[artwiz-aleczapka]: http://artwizaleczapka.sourceforge.net/
[artwiz-latin1]: http://sourceforge.net/projects/artwiz-latin1/
[ISO/IEC 8859-1]: https://en.wikipedia.org/wiki/ISO_8859-1
[Basic Latin]:https://en.wikipedia.org/wiki/C0_Controls_and_Basic_Latin
[Latin-1 Supplement]: https://en.wikipedia.org/wiki/C1_Controls_and_Latin-1_Supplement
[Unicode]: https://en.wikipedia.org/wiki/Unicode


Prerequisites
-------------

For OTF output:
- [Fontforge](https://fontforge.org/en-US/)

For PCF (legacy) output:
- [bdftopcf](https://www.x.org/releases/X11R7.7/doc/man/man1/bdftopcf.1.xhtml)


Building
--------

Building is rather straightforward:

```bash
make
```

This will create a `build` directory, and create generated `.pcf` and `.otf` files there.

You can opt to only generate either `.pcf` or `.otf` files by running `make pcf` or `make otf`.

If you wish to clean up the build output, you can run `make clean`.


Installation
------------

You have two options for installation: either installing the fonts system-wide (the default) or installing them in your home directory. (which doesn't require `root` access)

### System-wide installation

```bash
sudo make install
```

This will install the fonts to `/usr/share/fonts/artwiz-fonts-wl`, and create the Xorg config file
`/etc/X11/xorg.conf.d/40-x-fonts.conf` to enable them. It will also run `fc-cache` to update the system fontconfig cache.

You may specify values for the `DESTDIR`, `SYSCONFDIR`, `PREFIX`, `FONTDIR`, or `TARGET` variables after `make` in order to override the default paths.
(defaults: `DESTDIR=/`, `SYSCONFDIR=/etc`, `PREFIX=/usr`, `FONTDIR=$(PREFIX)/share/fonts`, `TARGET=$(FONTDIR)/artwiz-fonts-wl`)

You can also opt to only install either `.pcf` or `.otf` fonts using `sudo make install-pcf` or `sudo make install-otf`.


### Home directory installation

Currently, only the OTF variant can be installed in your home directory.

```bash
make install-user
```

This will install the `.otf` fonts into `~/.fonts/artwiz-fonts-wl/`, and then regenerate the fontconfig cache for the current user.


### Fontconfig configuration

If you use Ubuntu or another distro that disables bitmap fonts in fontconfig by default, you'll have to re-enable them:

```bash
rm /etc/fonts/conf.d/30-debconf-no-bitmaps.conf
```

On Arch Linux, this file is named `/etc/fonts/conf.d/70-no-bitmaps.conf`, and the file
`/etc/fonts/conf.avail/70-yes-bitmaps.conf` should be linked in its place:

```bash
rm /etc/fonts/conf.d/70-no-bitmaps.conf
ln -s /etc/fonts/conf.avail/70-yes-bitmaps.conf /etc/fonts/conf.d/
```


Testing Without Installation
----------------------------

Do the following:

 * Update the fontconfig cache:

		fc-cache -fv /PATH/TO/artwiz-fonts-wl

 * Create a new file `/etc/X11/xorg.conf.d/40-x-fonts.conf` with the contents:

		Section "Files"
			FontPath "/PATH/TO/artwiz-fonts-wl"
		EndSection


 * Add this to your fontconfig config file (eg. `/etc/fonts/local.conf`):

		<dir>/PATH/TO/artwiz-fonts-wl:unscaled</dir>


 * If you use Ubuntu or another distro that disables bitmap fonts in fontconfig by default:

		rm /etc/fonts/conf.d/30-debconf-no-bitmaps.conf

	On Arch Linux, this file is named `/etc/fonts/conf.d/70-no-bitmaps.conf`, and the file
	`/etc/fonts/conf.avail/70-yes-bitmaps.conf` should be linked in its place:

		rm /etc/fonts/conf.d/70-no-bitmaps.conf
		ln -s /etc/fonts/conf.avail/70-yes-bitmaps.conf /etc/fonts/conf.d/


 * Either restart X, or run:

		xset +fp /PATH/TO/artwiz-fonts-wl


 * Test it:

		xlsfonts | grep drift
		fc-list | grep drift


NOTE: Your installation may vary depending on your distro.


GTK Menus
---------

You might want to use these fonts in GTK 2.x apps menus and other widgets.
([screenshot](http://artwiz-latin1.sourceforge.net/screenshots/snap-gtk.png))

Edit `~/.gtkrc.mine`, and add:

```
gtk-font-name = "snap 10"
```

and ensure that `~/.gtkrc-2.0` contains:

```
include "/home/your_home/.gtkrc.mine"
```

(`your_home` is just an example)


License
-------

artwiz-fonts-wl is released under the terms of [the GNU General Public License
(GPL) version 2](https://opensource.org/licenses/GPL-2.0). Read file
[COPYING]() for detailed info.

The Artwiz fonts were originally released under the [ZIWTRA B00GIE LICENSE
(ZBL)][ZBL].

[ZBL]: https://web.archive.org/web/20011214092005/http://artwiz.artramp.org/LICENSE
