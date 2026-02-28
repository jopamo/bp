# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools dot-a

DESCRIPTION="standard informational utilities and process-handling tools"
HOMEPAGE="https://gitlab.com/procps-ng/procps"
SNAPSHOT=26e0cbeb28a94c9334614cbcc94689b9f3d4781a
SRC_URI="https://gitlab.com/procps-ng/procps/-/archive/${SNAPSHOT}/procps-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
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
	use static-libs && lto-guarantee-fat

	local myconf=(
		$(use_enable static-libs static)
		$(use_with ncurses)
		$(use_with systemd)
		--disable-kill
		--disable-modern-top
		--disable-nls
		--disable-rpath
		--disable-w-from
		--disable-watch8bit
		--enable-colorwatch
		--enable-sigwinch
		--enable-skill
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs && strip-lto-bytecode
}
