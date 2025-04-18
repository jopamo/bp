# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xlib-based client API for the XTEST & RECORD extensions library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=abf3ff74b97c4231d2324d66318bfa1d22e44913
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXtst/-/archive/${SNAPSHOT}/libXtst-${SNAPSHOT}.tar.bz2 -> libXtst-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxtst-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND=">=xgui-lib/libX11-1.6.2
	>=xgui-lib/libXext-1.3.2
	>=xgui-lib/libXi-1.7.2
	xgui-tools/xorgproto"

src_prepare() {
	sed -i 's|http://www.oasis-open.org/docbook/xml/4\.3/docbookx\.dtd|http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd|g' man/XTest.xml || die

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
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
