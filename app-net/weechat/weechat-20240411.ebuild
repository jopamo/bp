# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake python-single-r1 xdg

DESCRIPTION="Portable and multi-interface IRC client"
HOMEPAGE="https://weechat.org/"

SNAPSHOT=c112d0aafafc253a88cf5fd195719a490318cb2c
SRC_URI="https://github.com/weechat/weechat/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

NETWORKS="+irc"
PLUGINS="+alias +buflist +charset +exec +fifo +fset +logger +relay +scripts +trigger +typing +xfer"

SCRIPT_LANGS="guile lua +perl php +python ruby tcl"

IUSE="man test ${SCRIPT_LANGS} ${PLUGINS} ${INTERFACES} ${NETWORKS}"

RESTRICT="!test? ( test )"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DLIBDIR="${EPREFIX}/usr/lib"
		-DENABLE_JAVASCRIPT=OFF
		-DENABLE_LARGEFILE=ON
		-DENABLE_NCURSES=ON
		-DENABLE_ALIAS=$(usex alias)
		-DENABLE_BUFLIST=$(usex buflist)
		-DENABLE_CHARSET=$(usex charset)
		-DENABLE_DOC=OFF
		-DENABLE_EXEC=$(usex exec)
		-DENABLE_FIFO=$(usex fifo)
		-DENABLE_FSET=$(usex fset)
		-DENABLE_GUILE=$(usex guile)
		-DENABLE_IRC=$(usex irc)
		-DENABLE_LOGGER=$(usex logger)
		-DENABLE_LUA=$(usex lua)
		-DENABLE_MAN=$(usex man)
		-DENABLE_NLS=OFF
		-DENABLE_PERL=$(usex perl)
		-DENABLE_PHP=$(usex php)
		-DENABLE_PYTHON=$(usex python)
		-DENABLE_RELAY=$(usex relay)
		-DENABLE_RUBY=$(usex ruby)
		-DENABLE_SCRIPT=$(usex scripts)
		-DENABLE_SCRIPTS=$(usex scripts)
		-DENABLE_SPELL=NO
		-DENABLE_TCL=$(usex tcl)
		-DENABLE_TESTS=$(usex test)
		-DENABLE_TRIGGER=$(usex trigger)
		-DENABLE_TYPING=$(usex typing)
		-DENABLE_XFER=$(usex xfer)
	)
	cmake_src_configure
}
