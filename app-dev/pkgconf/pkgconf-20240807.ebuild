# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="a program which helps to configure compiler and linker flags for development libraries"
HOMEPAGE="https://git.sr.ht/~kaniini/pkgconf"

SNAPSHOT=a88c0d962a987c62d98ede5a738e37ec71005cbd
SRC_URI="https://github.com/pkgconf/pkgconf/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RESTRICT="test"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	dosym pkgconf usr/bin/pkg-config
	use static-libs || find "${ED}" -name '*.a' -delete
}
