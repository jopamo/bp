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

IUSE="modern-top nls ncurses static-libs systemd unicode"

DEPEND="
	ncurses? ( lib-sys/ncurses )
	systemd? ( sys-app/systemd )
"

src_configure() {
	local myconf=(
		$(use_enable modern-top)
		$(use_with ncurses)
		$(use_enable nls)
		$(use_enable static-libs static)
		$(use_with systemd)
		$(use_enable unicode watch8bit)
		--disable-w-from
		--disable-kill
		--disable-rpath
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
