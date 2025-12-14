# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=04c5b7c9209801aa1bdbf279ccdcde0d57874a55

inherit autotools flag-o-matic

DESCRIPTION="The Fast Lexical Analyzer"
HOMEPAGE="https://github.com/westes/flex"
SRC_URI="https://github.com/westes/flex/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/flex-${SNAPSHOT}

LICENSE="FLEX"
SLOT="0"
KEYWORDS="amd64 arm64"

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
	dosym -r /usr/bin/flex /usr/bin/lex
	use static-libs || find "${ED}" -name '*.a' -delete
}
