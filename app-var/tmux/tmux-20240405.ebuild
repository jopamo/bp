# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Terminal multiplexer"
HOMEPAGE="https://tmux.github.io/"

SNAPSHOT=4bb6da75bada96b3fa5086487ad0f241dea874bb
SRC_URI="https://github.com/tmux/tmux
https://github.com/tmux/tmux/archive/${SNAPSHOT}.tar.gz -> tmux-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/tmux-${SNAPSHOT}"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/tmux/tmux"
	inherit
else
	SNAPSHOT=4bb6da75bada96b3fa5086487ad0f241dea874bb
	SRC_URI="https://github.com/tmux/tmux/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug"

DEPEND="
	lib-dev/libevent
	virtual/curses
"

PATCHES=( "${FILESDIR}/${PN}-2.4-flags.patch" )

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
