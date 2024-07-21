# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="standard informational utilities and process-handling tools"
HOMEPAGE="https://gitlab.com/procps-ng/procps"

SNAPSHOT=9730cd49e9fb8bbaeb17574376f3c259698b5272
SRC_URI="https://gitlab.com/procps-ng/procps/-/archive/${SNAPSHOT}/procps-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/procps-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ncurses static-libs systemd"

DEPEND="
	ncurses? ( virtual/curses )
	systemd? ( app-core/systemd )
"

src_prepare() {
	default

	if [[ ${PV} == *9999 ]] ; then
		po/update-potfiles
		eautoreconf
		sed -i -e "s/UNKNOWN/$(git log -n1 --pretty=format:%cd --date=format:%Y%m%d)/g" "configure" || die
	elif [[ ${PV} == 20* ]] ; then
		po/update-potfiles
		eautoreconf
		sed -i -e "s/UNKNOWN/${PV}/g" "configure" || die
	fi
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
