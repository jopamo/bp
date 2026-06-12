# Distributed under the terms of the GNU General Public License v2

inherit qa-policy

DESCRIPTION="BSD replacement for libreadline"
HOMEPAGE="https://thrysoee.dk/editline/"
SNAPSHOT=156e25a4379192551f57ee99a3cc5dbf62cc29d9
SRC_URI="https://salsa.debian.org/debian/libedit/-/archive/${SNAPSHOT}/libedit-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libedit-${SNAPSHOT}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="virtual/curses[static-libs?]"

src_prepare() {
	qa-policy-configure
	default
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
	qa-policy-install
}
