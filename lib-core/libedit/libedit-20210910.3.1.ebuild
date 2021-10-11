# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV=${PV/./-}
MY_P=${PN}-${MY_PV}

DESCRIPTION="BSD replacement for libreadline"
HOMEPAGE="https://thrysoee.dk/editline/"
SRC_URI="https://thrysoee.dk/editline/${MY_P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="virtual/curses[static-libs?]"

S="${WORKDIR}/${MY_P}"

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		--enable-fast-install
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
