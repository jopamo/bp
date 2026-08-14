# Distributed under the terms of the GNU General Public License v2

MY_PN="${PN/-bin/}"
MY_PV="${PV/-r*/}"

inherit unpacker xdg

DESCRIPTION="All-in-one voice and text chat for gamers and communities"
HOMEPAGE="https://discord.com/"
SRC_URI="amd64? ( https://dl.discordapp.net/apps/linux/${PV}/${P}.tar.gz )"

LICENSE="DISCORD"
RESTRICT="strip mirror"

SLOT="0"
KEYWORDS="amd64"

S="${WORKDIR}/${MY_PN^}"

IUSE="seccomp"

RDEPEND="
	app-compression/bzip2
	virtual/dbus
	fonts/fontconfig
	lib-core/expat
	lib-core/libcap
	lib-dev/nspr
	lib-dev/nss
	lib-core/glib
	lib-print/cups
	xgui-icontheme/adwaita-icon-theme
	xgui-lib/at-spi2-core
	xgui-lib/cairo
	xgui-lib/gdk-pixbuf
	xgui-lib/gtk3
	xgui-lib/libxcb
	xgui-lib/libxkbcommon
	xgui-lib/pango
	xgui-tools/alsa-lib
	xgui-lib/freetype
"

DESTDIR="/opt/${MY_PN}"

QA_PREBUILT="*"

CONFIG_CHECK="~USER_NS"

src_unpack() {
	unpack ${MY_PN}-${MY_PV}.tar.gz
}

src_prepare() {
	default
	# remove post-install script
	rm postinst.sh || die "the removal of the unneeded post-install script failed"

	# USE seccomp
	if ! use seccomp; then
		sed -i '/^Exec=/s|/usr/bin/discord|/usr/bin/discord --disable-seccomp-filter-sandbox|' \
			discord.desktop || die "sed failed"
	fi
}

src_install() {
	exeinto "${DESTDIR}"
	doexe discord updater_bootstrap

	insinto "${DESTDIR}"
	doins discord.png

	insinto /usr/share/icons/hicolor/256x256/apps/
	doins discord.png

	insinto /usr/share/applications/
	doins discord.desktop

	dosym -r "${DESTDIR}/discord" "/usr/bin/${MY_PN}"
}
