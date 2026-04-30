# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="a program which helps to configure compiler and linker flags for development libraries"
HOMEPAGE="https://git.sr.ht/~kaniini/pkgconf"
SNAPSHOT=2868f114b071fb2933e88bb2f8f06a9ad767cff6
SRC_URI="https://github.com/pkgconf/pkgconf/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/pkgconf-${SNAPSHOT}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RESTRICT="test"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	qa-policy-configure
	default
}

src_install() {
	default
	dosym -r /usr/bin/pkgconf /usr/bin/pkg-config
	qa-policy-install
	use static-libs || find "${ED}" -name '*.a' -delete
}
