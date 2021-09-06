# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=deb85ad4936d4ca32cc2260ce43323d47936410d

inherit autotools

DESCRIPTION="A free stand-alone ini file parsing library"
HOMEPAGE="http://ndevilla.free.fr/iniparser/"
SRC_URI="https://github.com/ndevilla/iniparser/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RESTRICT="test"

PATCHES=( "${FILESDIR}/${PN}-3.0-autotools.patch" )

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
