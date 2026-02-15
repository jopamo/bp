# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="BSD replacement for libreadline"
HOMEPAGE="https://thrysoee.dk/editline/"
SNAPSHOT=cc5ed18287a67b097c36c2b9b27585e1f236f3ea
SRC_URI="https://salsa.debian.org/debian/libedit/-/archive/${SNAPSHOT}/libedit-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libedit-${SNAPSHOT}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="virtual/curses[static-libs?]"

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		--enable-fast-install
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
