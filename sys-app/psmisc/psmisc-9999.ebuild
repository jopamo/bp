# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="A set of tools that use the proc filesystem"
HOMEPAGE="http://psmisc.sourceforge.net/"
EGIT_REPO_URI="https://gitlab.com/psmisc/psmisc"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6 nls X"

RDEPEND="lib-sys/ncurses"

DEPEND="${RDEPEND}
	sys-devel/libtool"

src_prepare() {
	po/update-potfiles
	default
	eautoreconf
	sed -i -e "s/UNKNOWN/$(git log -1 --format="%at" | xargs -I{} date -d @{} +%Y%m%d)/g" "configure" || die
}

src_configure() {
	local myconf=(
		--disable-harden-flags
		$(use_enable nls)
		$(use_enable ipv6)
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	use X || rm -f "${ED%/}"/usr/bin/pstree.x11
}
