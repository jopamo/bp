# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=7b073fdda2242a8e4a0f70244c0ae83d34f099b1

inherit autotools flag-o-matic

DESCRIPTION="The Fast Lexical Analyzer"
HOMEPAGE="https://github.com/westes/flex"
SRC_URI="https://github.com/westes/flex/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="FLEX"
SLOT="0"
#KEYWORDS="amd64 arm64"
#yy_init_buffer changes causing problems

IUSE="nls static-libs test"

DEPEND="sys-devel/m4
		app-compression/xz-utils
		nls? ( sys-devel/gettext )
		test? ( sys-devel/bison )"

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

	ECONF_SOURCE=${S} \
	econf \
		--disable-shared \
		$(use_enable nls)
}

src_test() {
	emake check
}

src_install() {
	default
	dosym flex /usr/bin/lex
	use static-libs || find "${ED}" -name '*.a' -delete
}
