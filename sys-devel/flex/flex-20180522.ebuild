# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools flag-o-matic

DESCRIPTION="The Fast Lexical Analyzer"
HOMEPAGE="https://github.com/westes/flex"

SNAPSHOT=98018e3f58d79e082216d406866942841d4bdf8a
SRC_URI="https://github.com/westes/flex/archive/${SNAPSHOT}.zip -> ${P}.zip"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="FLEX"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="nls static-libs test"

DEPEND="sys-devel/m4
		app-compression/xz-utils
		nls? ( sys-devel/gettext )
		test? ( sys-devel/bison )"

src_prepare() {
	#${S}/autogen.sh
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
	use static-libs || find "${ED}" -name "*.la" -delete || die
	dosym flex /usr/bin/lex
}
