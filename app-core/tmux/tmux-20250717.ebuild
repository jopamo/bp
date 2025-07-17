# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Terminal multiplexer"
HOMEPAGE="https://tmux.github.io/"
SNAPSHOT=32b7b3a6f7f4df4ddb60861a286e8946c3c57392
SRC_URI="https://github.com/tmux/tmux/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/tmux-${SNAPSHOT}

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug"

DEPEND="
	lib-dev/libevent
	virtual/curses
"

PATCHES=( "${FILESDIR}/tmux-2.4-flags.patch" )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--sysconfdir="${EPREFIX}"/etc
		$(use_enable debug)
	)
	econf "${myconf[@]}"
}

src_install() {
	default

	insinto /etc
	doins "${FILESDIR}"/tmux.conf
}
