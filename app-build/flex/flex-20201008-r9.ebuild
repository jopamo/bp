# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=1e9c36271ea388cd155f2b7808c71113301e1631

inherit autotools qa-policy

DESCRIPTION="The Fast Lexical Analyzer"
HOMEPAGE="https://github.com/westes/flex"
SRC_URI="https://github.com/westes/flex/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/flex-${SNAPSHOT}

LICENSE="FLEX"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

RDEPEND="
	app-build/m4
"
BDEPEND="
	app-build/gettext
	app-build/m4
	test? ( app-build/bison )
"

PATCHES=( "${FILESDIR}"/flex-20260224-parallel-bootstrap-race.patch )

src_prepare() {
	default
	eautoreconf

	if ! use test ; then
		sed -i \
			-e '/^SUBDIRS =/,/^$/{/tests/d}' \
			Makefile.in || die
	fi
}

src_configure() {
	qa-policy-configure
	ECONF_SOURCE=${S} econf \
		--disable-nls \
		$(use_enable static-libs static)
}

src_test() {
	use test || return 0

	emake check
}

src_install() {
	default
	dosym -r /usr/bin/flex /usr/bin/lex
	qa-policy-install
}
