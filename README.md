DESCRIPTION
-----------

A set of fonts based on artwiz/artwiz-aleczapka with:

 * Full ISO-8859-1 support (german, portuguese, swedish etc. characters)
 * Bold version of each font.


BUILDING
--------

Building is rather straightforward:

	make

This will create a `build` directory, and create generated `.pcf` files there.

If you wish to clean up the build output, you can run `make clean`.


INSTALLATION
------------

Do the following:

 * Copy the fonts to your font dir:

		cd your_font_dir
		tar xvjf artwiz-latin1.tar.bz2
		cd artwiz-latin1
		fc-cache -fv ./

 * Create a new file `/etc/X11/xorg.conf.d/40-x-fonts.conf` with the contents:

		Section "Files"
			FontPath "your_font_dir/artwiz-latin1"
		EndSection


 * Add this to your fontconfig config file (eg. `/etc/fonts/local.conf`):

		<dir>your_font_dir/artwiz-latin1:unscaled</dir>


 * If you use Ubuntu or another distro that disables bitmap fonts in fontconfig:

		rm /etc/fonts/conf.d/30-debconf-no-bitmaps.conf

	(On ArchLinux, this file is named `/etc/fonts/conf.d/70-yes-bitmaps.conf`)


 * Either restart X, or run:

		xset +fp your_font_dir/artwiz-latin1


 * Test it:

		xlsfonts | grep snap
		fc-list | grep snap


NOTE: Your installation may vary depending on your distro.


GTK MENUS
---------

You might want to use these fonts in GTK apps menus and other widgets.
([screenshot](http://artwiz-latin1.sourceforge.net/screenshots/snap-gtk.png))

Edit `~/.gtkrc.mine`, and add:

	gtk-font-name = "snap 10"

and ensure that `~/.gtkrc-2.0` contains:

	include "/home/your_home/.gtkrc.mine"

(your_home is just an example)


CONTACT
-------

email: ld <dot> fifty <at> gmail <dot> com
irc: ld50 at freenode, and lethal at ptnet
http://sourceforge.net/projects/artwiz-latin1/
