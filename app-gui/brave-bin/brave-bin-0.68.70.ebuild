# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker linux-info

DESCRIPTION="Brave Browser: Secure, Fast & Private Web Browser with Adblocker"
HOMEPAGE="https://brave.com"
SRC_URI="amd64? ( https://github.com/brave/brave-browser/releases/download/v${PV}/brave-browser-nightly_${PV}_amd64.deb )"
S="${WORKDIR}"

RESTRICT="strip mirror"

LICENSE="https://raw.githubusercontent.com/brave/brave-browser/master/LICENSE"
SLOT="0/1"
KEYWORDS="amd64"

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

src_unpack() {
	:
}

src_install() {
	dodir /
	cd "${ED}" || die
	unpacker

	rm -rf etc usr/share/menu usr/share/doc usr/share/man || die
}

pkg_postinst() {
		ewarn ""
		ewarn "The namespace sandbox aims to replace the setuid sandbox. It has the advantage "
		ewarn "of not requiring a setuid binary. It's based on (unprivileged) user namespaces in the Linux kernel."
		ewarn ""
		ewarn "Even with proper kernel support, you must increase the user.max_user_namespaces default value of 0"
		ewarn "sysctl user.max_user_namespaces=<value>"
		ewarn ""
}
