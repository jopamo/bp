# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="BSD replacement for libreadline"
HOMEPAGE="https://thrysoee.dk/editline/"

SNAPSHOT=08da76b7e6d925652df0bfc49b085446bbd993bc
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
