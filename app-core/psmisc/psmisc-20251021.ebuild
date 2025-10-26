# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A set of tools that use the proc filesystem"
HOMEPAGE="http://psmisc.sourceforge.net/"
SNAPSHOT=f3b51bdc90b6b5cb610528cce3d8262a932d50f0
SRC_URI="https://gitlab.com/psmisc/psmisc/-/archive/${SNAPSHOT}/psmisc-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/psmisc-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6 nls X"

DEPEND="
	virtual/curses
	app-build/libtool
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
