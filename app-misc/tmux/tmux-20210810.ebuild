# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Terminal multiplexer"
HOMEPAGE="https://tmux.github.io/"
EGIT_REPO_URI="https://github.com/tmux/tmux.git"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/tmux/tmux"
	inherit git-r3
	EGIT_BRANCH="release/$(ver_cut 1).$(ver_cut 2)/master"
else
	SNAPSHOT=705411ea5cccf4607af9424e70a153f397d1fab6
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
