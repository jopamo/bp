# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="standard informational utilities and process-handling tools"
HOMEPAGE="https://gitlab.com/procps-ng/procps"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://gitlab.com/procps-ng/procps.git"
	inherit git-r3 autotools
	KEYWORDS="~amd64 ~arm64"
elif [[ ${PV} == 20* ]]; then
	SNAPSHOT=23da4f40ea27afe998e92ca317f2dcb48a6ffc1f
	SRC_URI="https://gitlab.com/procps-ng/procps/-/archive/${SNAPSHOT}/procps-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
	S=${WORKDIR}/procps-${SNAPSHOT}
	inherit autotools
	KEYWORDS="amd64 arm64"
else
	SRC_URI="mirror://sourceforge/${PN}-ng/${PN}-ng-${PV}.tar.xz"
	KEYWORDS="amd64 arm64"
fi

LICENSE="GPL-2"
SLOT="0"

IUSE="musl ncurses static-libs systemd"

DEPEND="
	ncurses? ( virtual/curses )
	systemd? ( app-core/systemd )
"

src_prepare() {
	use musl && eapply "${FILESDIR}"/musl-fixes.patch

	default

	if [[ ${PV} == *9999 ]] ; then
		po/update-potfiles
		eautoreconf
		sed -i -e "s/UNKNOWN/$(git log -1 --format="%at" | xargs -I{} date -d @{} +%Y%m%d)/g" "configure" || die
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
