# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=4bef811283e0ec1658c60e09950bd5a1ddc92e4b

inherit autotools

DESCRIPTION="A free stand-alone ini file parsing library"
HOMEPAGE="http://ndevilla.free.fr/iniparser/"
SRC_URI="https://github.com/ndevilla/iniparser/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/iniparser-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RESTRICT="test"

PATCHES=( "${FILESDIR}/iniparser-3.0-autotools.patch" )

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
