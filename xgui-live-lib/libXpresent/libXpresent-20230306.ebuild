# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xpresent library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=6bbbcf9218bbc686389387142978f90a3917c39a
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXpresent/-/archive/${SNAPSHOT}/libXpresent-${SNAPSHOT}.tar.bz2 -> libXpresent-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libXpresent-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
