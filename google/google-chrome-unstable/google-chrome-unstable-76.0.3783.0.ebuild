# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info gnome2-utils unpacker xdg-utils

DESCRIPTION="The web browser from Google"
HOMEPAGE="https://www.google.com/chrome"
SRC_URI="https://dl.google.com/linux/chrome/deb/pool/main/g/${PN}/${P}-1_amd64.deb"

LICENSE="google-chrome"
SLOT="0/1"
KEYWORDS="amd64"

RESTRICT="bindist mirror strip"

RDEPEND="
	gui-lib/at-spi2-atk
	app-compression/bzip2
	app-misc/ca-certificates
	gui-lib/atk
	lib-dev/expat
	lib-dev/glib:2
	lib-dev/nspr
	>=lib-dev/nss-3.26
	lib-media/alsa-lib
	lib-media/fontconfig
	lib-media/freetype:2
	lib-print/cups
	sys-app/dbus
	lib-sys/libcap
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	>=x11-libs/libX11-1.5.0
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/libxcb
	x11-libs/pango
	x11-misc/xdg-utils
"

QA_PREBUILT="*"
QA_DESKTOP_FILE="usr/share/applications/google-chrome.*\\.desktop"
S=${WORKDIR}
CHROME_HOME="opt/google/chrome${PN#google-chrome}"

DISABLE_AUTOFORMATTING="yes"

pkg_setup() {
		ERROR_PID_NS="PID_NS is required for sandbox to work"
		ERROR_NET_NS="NET_NS is required for sandbox to work"
		ERROR_USER_NS="USER_NS is required for sandbox to work"
		ERROR_SECCOMP_FILTER="SECCOMP_FILTER is required for sandbox to work"
		ERROR_ADVISE_SYSCALLS="CONFIG_ADVISE_SYSCALLS is required for the renderer (bug #552576)"
		ERROR_COMPAT_VDSO="CONFIG_COMPAT_VDSO causes segfaults (bug #556286)"
		ERROR_GRKERNSEC="CONFIG_GRKERNSEC breaks sandbox (bug #613668)"
		CONFIG_CHECK="~PID_NS ~NET_NS ~SECCOMP_FILTER ~USER_NS ~ADVISE_SYSCALLS ~!COMPAT_VDSO ~!GRKERNSEC"
		check_extra_config
}

src_unpack() {
	:
}

src_install() {
	dodir /
	cd "${ED}" || die
	unpacker

	rm -rf etc usr/share/menu usr/share/doc usr/share/man || die

	local size
	for size in 16 22 24 32 48 64 128 256 ; do
		newicon -s ${size} "${CHROME_HOME}/product_logo_${size}_dev.png" ${PN}.png
	done
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update

}

