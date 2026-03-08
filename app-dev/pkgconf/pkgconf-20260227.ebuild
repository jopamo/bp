# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools qa-policy

DESCRIPTION="a program which helps to configure compiler and linker flags for development libraries"
HOMEPAGE="https://git.sr.ht/~kaniini/pkgconf"
SNAPSHOT=9addd3841a3f537a7a6cd1ad0b2f4cadde9d1e54
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
