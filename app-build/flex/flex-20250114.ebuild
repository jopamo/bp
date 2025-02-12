# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=051ab9ed8c8ba43614c9f742c3e3452a0ff0ce95

inherit autotools flag-o-matic

DESCRIPTION="The Fast Lexical Analyzer"
HOMEPAGE="https://github.com/westes/flex"
SRC_URI="https://github.com/westes/flex/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="FLEX"
SLOT="0"
#KEYWORDS="amd64 arm64"

IUSE="static-libs test"

DEPEND="
	app-build/m4
	app-compression/xz-utils
	test? ( app-build/bison )
"

src_prepare() {
	eautoreconf
	default

	if ! use test ; then
		sed -i \
			-e '/^SUBDIRS =/,/^$/{/tests/d}' \
			Makefile.in || die
	fi
}

src_configure() {
	use static-libs && append-ldflags -static

	ECONF_SOURCE=${S} econf --disable-shared
}

src_test() {
	emake check
}

src_install() {
	default
	dosym flex usr/bin/lex
	use static-libs || find "${ED}" -name '*.a' -delete
}
