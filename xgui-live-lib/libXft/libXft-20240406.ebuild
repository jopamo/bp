# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xft library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=e736f48ba2fd4263ca6f692e27916a914447af4e
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXft/-/archive/${SNAPSHOT}/libXft-${SNAPSHOT}.tar.bz2 -> libXft-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxft-${SNAPSHOT}"

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
