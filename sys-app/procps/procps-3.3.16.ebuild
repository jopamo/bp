# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="standard informational utilities and process-handling tools"
HOMEPAGE="https://gitlab.com/procps-ng/procps"
SRC_URI="mirror://sourceforge/${PN}-ng/${PN}-ng-${PV}.tar.xz"
S="${WORKDIR}/${PN}-ng-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ncurses static-libs systemd"

DEPEND="
	ncurses? ( lib-sys/ncurses )
	systemd? ( sys-app/systemd )
"

src_prepare() {
	default
	sed -i 's,ncursesw/ncurses.h,ncurses.h,g' watch.c

}
src_configure() {
	local myconf=(
		$(use_with ncurses)
		$(use_enable static-libs static)
		$(use_with systemd)
		--enable-watch8bit
		--disable-w-from
		--disable-kill
		--disable-rpath
		--disable-nls
		--disable-modern-top
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
