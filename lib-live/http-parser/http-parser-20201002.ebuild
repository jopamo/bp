# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="HTTP request/response parser for C"
HOMEPAGE="https://github.com/nodejs/http-parser"

SNAPSHOT=ec8b5ee63f0e51191ea43bb0c6eac7bfbff3141d
SRC_URI="https://github.com/nodejs/http-parser/archive/${SNAPSHOT}.tar.gz -> http-parser-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/http-parser-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
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
