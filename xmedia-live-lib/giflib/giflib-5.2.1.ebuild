# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Library to handle, display and manipulate GIF images"
HOMEPAGE="https://sourceforge.net/projects/giflib/"
SRC_URI="mirror://sourceforge/giflib/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

filter-flags -Wl,-z,defs

src_compile() {
	emake PREFIX="${ED}"/usr LIBDIR="${ED}"/usr/lib CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	emake PREFIX="${ED}"/usr LIBDIR="${ED}"/usr/lib CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" install

	use static-libs || rm -vf "${ED}"/usr/lib/libgif.a
}
