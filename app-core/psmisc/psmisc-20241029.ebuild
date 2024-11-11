# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A set of tools that use the proc filesystem"
HOMEPAGE="http://psmisc.sourceforge.net/"

SNAPSHOT=dfd9ac4d50aac48de343fdfcbd24e0181a2f96e0
SRC_URI="https://gitlab.com/psmisc/psmisc/-/archive/${SNAPSHOT}/psmisc-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

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
