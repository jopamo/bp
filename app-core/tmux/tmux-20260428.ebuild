# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="Terminal multiplexer"
HOMEPAGE="https://tmux.github.io/"
SNAPSHOT=d85f1b942da3c451bdad1f2f794673a44b2d682c
SRC_URI="https://github.com/tmux/tmux/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/tmux-${SNAPSHOT}

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug"

QA_CONFIG_IMPL_DECL_SKIP=(
	# OpenBSD compatibility probes in configure.
	strtonum
	recallocarray
)

DEPEND="
	lib-dev/libevent
	virtual/curses
"

#PATCHES=( "${FILESDIR}/tmux-2.4-flags.patch" )

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
