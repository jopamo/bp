# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Terminal multiplexer"
HOMEPAGE="https://tmux.github.io/"

SNAPSHOT=43530d4397f94beed27acb8f5610338b6dbcc05a
SRC_URI="https://github.com/tmux/tmux
https://github.com/tmux/tmux/archive/${SNAPSHOT}.tar.gz -> tmux-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/tmux-${SNAPSHOT}"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/tmux/tmux"
	inherit
else
	SNAPSHOT=43530d4397f94beed27acb8f5610338b6dbcc05a
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
