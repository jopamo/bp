# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools toolchain-funcs

MY_PV=${PV/./-}
MY_P=${PN}-${MY_PV}

DESCRIPTION="BSD replacement for libreadline"
HOMEPAGE="https://thrysoee.dk/editline/"
SRC_URI="https://thrysoee.dk/editline/${MY_P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND=">=lib-sys/ncurses-5.9-r3[static-libs?]"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		--enable-fast-install
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	rm "${ED%/}/usr/share/man/man3/history.3" || die
}
