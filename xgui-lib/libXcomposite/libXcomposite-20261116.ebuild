# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="X.Org Xcomposite library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=56e7501b509945cabaa5c1c4672efed5f59694dd
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

src_configure() {
	qa-policy-configure
	default
}

src_install() {
	default
	qa-policy-install
	use static-libs || find "${ED}" -name '*.a' -delete
}
