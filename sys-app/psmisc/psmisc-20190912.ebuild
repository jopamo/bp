# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=2209bc12fedd75aca8b79801a842b35f87f9b727

inherit autotools

DESCRIPTION="A set of tools that use the proc filesystem"
HOMEPAGE="http://psmisc.sourceforge.net/"
SRC_URI="https://gitlab.com/psmisc/psmisc/-/archive/${SNAPSHOT}/psmisc-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="ipv6 nls X"

RDEPEND="lib-sys/ncurses"

DEPEND="${RDEPEND}
	sys-devel/libtool"

src_prepare() {
	po/update-potfiles
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--disable-harden-flags
		$(use_enable nls)
		$(use_enable ipv6)
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	default
	use X || rm -f "${ED%/}"/usr/bin/pstree.x11
}
