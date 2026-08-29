# Distributed under the terms of the GNU General Public License v2

inherit doins unpacker xdg

DESCRIPTION="Launcher for the Steam software distribution service"
HOMEPAGE="https://store.steampowered.com/about/"
SRC_URI="
	amd64? (
		https://repo.steampowered.com/steam/archive/stable/steam-launcher_${PV}_amd64.deb
			-> ${P}-amd64.deb
	)
"

S="${WORKDIR}"

LICENSE="Steam MIT"
SLOT="0"
KEYWORDS="amd64"

RESTRICT="bindist mirror strip"

QA_PREBUILT="*"

RDEPEND="
	app-compression/tar
	app-compression/xz-utils
	app-core/bash
	app-core/file
	app-core/lsof
	app-lang/python
	app-net/curl
	lib-core/glib
	lib-dev/nss
	virtual/dbus
	xgui-lib/libX11
	xgui-lib/libXinerama
	xgui-lib/libxcb
	xgui-lib/libxkbcommon
	xgui-lib/xdg-user-dirs
	xgui-lib/xdg-utils
	xgui-tools/alsa-lib
	xgui-tools/mesa
	xmedia-lib/vulkan-loader
"

src_prepare() {
	default

	# Do not install Debian APT integration or its package-management helper.
	rm -r \
		etc/apt \
		usr/share/keyrings \
		usr/bin/steamdeps \
		usr/lib/steam/bin_steamdeps.py \
		usr/lib/steam/steam_launcher ||
		die "failed removing Debian-specific Steam integration"

	sed -i \
		-e '/^X-KDE-RunOnDiscreteGpu=/d' \
		usr/share/applications/steam.desktop ||
		die "failed removing deprecated desktop entry key"

	gzip -d usr/share/man/man6/steam.6.gz ||
		die "failed decompressing Steam manual page"
}

src_install() {
	dodir /usr/lib
	cp -a usr/lib/steam "${ED}"/usr/lib/ ||
		die "failed installing Steam launcher payload"

	dodir /usr/bin
	dosym -r /usr/lib/steam/bin_steam.sh /usr/bin/steam

	insinto /usr/share/applications
	doins usr/share/applications/steam.desktop

	insinto /usr/share/icons
	doins -r usr/share/icons/hicolor

	insinto /usr/share/metainfo
	doins usr/share/metainfo/com.valvesoftware.Steam.metainfo.xml

	insinto /usr/share/pixmaps
	doins usr/share/pixmaps/*

	doman usr/share/man/man6/steam.6

	udev_dorules lib/udev/rules.d/*.rules
}

pkg_preinst() {
	xdg_pkg_preinst
}

pkg_postinst() {
	udev_reload
	xdg_pkg_postinst
}

pkg_postrm() {
	udev_reload
	xdg_pkg_postrm
}
