# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xcursor library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=09617bcc9a0f1b5072212da5f8fede92ab85d157
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXcursor/-/archive/${SNAPSHOT}/libXcursor-${SNAPSHOT}.tar.bz2 -> libXcursor-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcursor-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RDEPEND=">=xgui-live-lib/libXrender-0.9.8
	>=xgui-live-lib/libXfixes-5.0.1
	>=xgui-live-lib/libX11-1.6.2"
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--with-icondir=/usr/share/cursors/xorg-x11
		--with-cursorpath='~/.cursors:~/.icons:/usr/local/share/cursors/xorg-x11:/usr/local/share/cursors:/usr/local/share/icons:/usr/local/share/pixmaps:/usr/share/cursors/xorg-x11:/usr/share/cursors:/usr/share/pixmaps/xorg-x11:/usr/share/icons:/usr/share/pixmaps'
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
