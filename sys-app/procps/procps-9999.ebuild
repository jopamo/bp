# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="standard informational utilities and process-handling tools"
HOMEPAGE="https://gitlab.com/procps-ng/procps"
EGIT_REPO_URI="https://gitlab.com/procps-ng/procps.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ncurses static-libs systemd"

DEPEND="
	ncurses? ( lib-sys/ncurses )
	systemd? ( sys-app/systemd )
"

src_prepare() {
	po/update-potfiles
	default
	eautoreconf
	sed -i -e "s/UNKNOWN/$(git log -1 --format="%at" | xargs -I{} date -d @{} +%Y%m%d)/g" "configure" || die
}

src_configure() {
	local myconf=(
		$(use_with ncurses)
		$(use_enable static-libs static)
		$(use_with systemd)
		--disable-watch8bit
		--disable-w-from
		--disable-kill
		--disable-rpath
		--disable-nls
		--disable-modern-top
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
