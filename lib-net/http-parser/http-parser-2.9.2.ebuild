# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="HTTP request/response parser for C"
HOMEPAGE="https://github.com/nodejs/http-parser"
SRC_URI="https://github.com/nodejs/http-parser/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/2.8.0"
KEYWORDS="amd64 arm64"
IUSE="static-libs"

src_prepare() {
	default
	tc-export CC AR
}

src_compile() {
	emake PREFIX="${EPREFIX}/usr" LIBDIR="${EPREFIX}/usr/lib" CFLAGS_FAST="${CFLAGS}" library
	use static-libs && emake CFLAGS_FAST="${CFLAGS}" package
}

src_test() {
	emake CFLAGS_DEBUG="${CFLAGS}" CFLAGS_FAST="${CFLAGS}" test
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" LIBDIR="${EPREFIX}/usr/lib" install
	use static-libs && dolib.a libhttp_parser.a
}
