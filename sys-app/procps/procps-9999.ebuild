# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="standard informational utilities and process-handling tools"
HOMEPAGE="https://gitlab.com/procps-ng/procps"
EGIT_REPO_URI="https://gitlab.com/procps-ng/procps.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+kill modern-top nls +ncurses static-libs systemd unicode"

DEPEND="
	ncurses? ( lib-sys/ncurses )
	systemd? ( sys-app/systemd )
"

RDEPEND="
	kill? (
		!sys-app/coreutils[kill]
		!sys-app/util-linux[kill]
	)
"

src_prepare() {
	po/update-potfiles
	default
	eautoreconf
	sed -i -e "s/UNKNOWN/$(git log -1 --format="%at" | xargs -I{} date -d @{} +%Y%m%d)/g" "configure" || die
}

src_configure() {
	local myconf=(
		$(use_enable kill)
		$(use_enable modern-top)
		$(use_with ncurses)
		$(use_enable nls)
		$(use_enable static-libs static)
		$(use_with systemd)
		$(use_enable unicode watch8bit)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
