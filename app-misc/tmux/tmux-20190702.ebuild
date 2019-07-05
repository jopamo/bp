# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Terminal multiplexer"
HOMEPAGE="https://tmux.github.io/"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tmux/tmux.git"
else
	SNAPSHOT=be5af704ad4f80a3ae77281aa617284a5a802e0e
	SRC_URI="https://github.com/tmux/tmux/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="ISC"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="debug"

DEPEND="
	lib-dev/libevent:0=
	lib-sys/ncurses:0=
"

PATCHES=( "${FILESDIR}/${PN}-2.4-flags.patch" )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--sysconfdir="${EPREFIX}"/etc
		$(use_enable debug)
	)
	econf "${myeconfargs[@]}"
}
