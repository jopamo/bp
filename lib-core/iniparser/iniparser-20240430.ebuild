# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=568ae4200e0330bbfbce43fc4e6652068238747b

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