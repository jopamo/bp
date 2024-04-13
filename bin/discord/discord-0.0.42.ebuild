# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"
MY_PV="${PV/-r*/}"

inherit unpacker xdg

DESCRIPTION="Brave Browser: Secure, Fast & Private Web Browser with Adblocker"
HOMEPAGE="https://brave.com"
SRC_URI="amd64? ( https://dl.discordapp.net/apps/linux/${PV}/${P}.tar.gz )"
S="${WORKDIR}"

RESTRICT="strip mirror"

LICENSE="DISCORD"
SLOT="0"
KEYWORDS="amd64"

IUSE="+seccomp"

RDEPEND="
	app-compression/bzip2
	app-core/dbus
	app-var/ca-certificates
	fonts/fontconfig
	lib-core/expat
	lib-core/libcap
	lib-dev/nspr
	lib-dev/nss
	lib-util/glib
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
	xgui-misc/freetype
"

DESTDIR="/opt/${MY_PN}"

QA_PREBUILT="*"

CONFIG_CHECK="~USER_NS"

S="${WORKDIR}/${MY_PN^}"

src_unpack() {
	unpack ${MY_PN}-${MY_PV}.tar.gz
}

src_prepare() {
	default
	# remove post-install script
	rm postinst.sh || die "the removal of the unneeded post-install script failed"

	# fix .desktop exec location
	sed -i "/Exec/s:/usr/share/discord/Discord:${DESTDIR}/${MY_PN^}:" \
		"${MY_PN}.desktop" ||
		die "fixing of exec location on .desktop failed"

	# USE seccomp
	if ! use seccomp; then
		sed -i '/Exec/s/Discord/Discord --disable-seccomp-filter-sandbox/' \
			"${MY_PN}.desktop" ||
			die "sed failed for seccomp"
	fi
}

src_install() {

	exeinto "${DESTDIR}"

	doexe "${MY_PN^}" chrome-sandbox libEGL.so libffmpeg.so libGLESv2.so libvk_swiftshader.so

	insinto "${DESTDIR}"
	doins chrome_100_percent.pak chrome_200_percent.pak icudtl.dat resources.pak snapshot_blob.bin v8_context_snapshot.bin
	insopts -m0755
	doins -r locales resources

	# Chrome-sandbox requires the setuid bit to be specifically set.
	# see https://github.com/electron/electron/issues/17972
	fowners root "${DESTDIR}/chrome-sandbox"
	fperms 4711 "${DESTDIR}/chrome-sandbox"

	# Crashpad is included in the package once in a while and when it does, it must be installed.
	# See #903616 and #890595
	[[ -x chrome_crashpad_handler ]] && doins chrome_crashpad_handler

	dosym "${DESTDIR}/${MY_PN^}" "/usr/bin/${MY_PN}"
}
