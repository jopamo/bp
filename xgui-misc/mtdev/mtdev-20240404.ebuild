# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Multitouch Protocol Translation Library"
HOMEPAGE="http://bitmath.org/code/mtdev/"
SNAPSHOT=9035c2225494b80b02e985fc7ee77880e0bd6993
SRC_URI="https://github.com/1g4-mirror/mtdev/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="app-kernel/linux-headers"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.la' -delete
}
