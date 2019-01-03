# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A set of tools that use the proc filesystem"
HOMEPAGE="http://psmisc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="ipv6 nls selinux X"

RDEPEND="lib-sys/ncurses
	selinux? ( lib-sys/libselinux )"

DEPEND="${RDEPEND}
	sys-devel/libtool"

src_configure() {
	local myeconfargs=(
		$(use_enable selinux)
		--disable-harden-flags
		$(use_enable nls)
		$(use_enable ipv6)
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	default
	use X || rm -f "${ED%/}"/usr/bin/pstree.x11
	[[ -s ${ED%/}/usr/bin/peekfd ]] || rm -f "${ED%/}"/usr/bin/peekfd
	[[ -e ${ED%/}/usr/bin/peekfd ]] || rm -f "${ED%/}"/usr/share/man/man1/peekfd.1
}
