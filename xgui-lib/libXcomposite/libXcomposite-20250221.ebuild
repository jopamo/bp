# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xcomposite library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=f796f0a862849765ac5b6b5e861ea548b421b8f0
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXcomposite/-/archive/${SNAPSHOT}/libXcomposite-${SNAPSHOT}.tar.bz2 -> libXcomposite-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcomposite-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	xgui-lib/libX11
	xgui-lib/libXfixes
	xgui-tools/xorgproto
"

src_prepare() {
	sed -i 's|http://www.oasis-open.org/docbook/xml/4\.3/docbookx\.dtd|http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd|g' man/Xcomposite.xml || die

	default
	eautoreconf
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
