# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Lightweight desktop notification daemon"
HOMEPAGE="https://dunst-project.org/"
SRC_URI="https://github.com/dunst-project/dunst/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	>=lib-core/glib-2.44
	xgui-lib/cairo
	xgui-lib/pango
	xgui-lib/pigment
	xgui-lib/libX11
	xgui-lib/libXext
	xgui-lib/libXinerama
	>=xgui-lib/libXrandr-1.5
	xgui-lib/libXScrnSaver
"
RDEPEND="${DEPEND}
	app-core/systemd[dbus]
	virtual/dbus
	xgui-lib/xdg-utils
"
BDEPEND="
	app-dev/pkgconf
	app-lang/perl
"

PATCHES=( "${FILESDIR}/${P}-test-path-diagnostic.patch" )

dunst_emake() {
	emake \
		CC="$(tc-getCC)" \
		PKG_CONFIG="$(tc-getPKG_CONFIG)" \
		VERSION="${PV}" \
		PREFIX="${EPREFIX}/usr" \
		SYSCONFDIR="${EPREFIX}/etc/xdg" \
		X11=1 WAYLAND=0 SYSTEMD=1 DUNSTIFY=0 \
		"$@"
}

src_compile() {
	dunst_emake
}

src_test() {
	dunst_emake test
}

src_install() {
	dunst_emake DESTDIR="${D}" install
	# Upstream installs this page even when dunstify is disabled.
	rm "${ED}/usr/share/man/man1/dunstify.1" || die
}
