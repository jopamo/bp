# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="X.Org xset application"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=3818c2ecf9d4772520a4c05acc2cc243c6280384
SRC_URI="https://gitlab.freedesktop.org/xorg/app/xset/-/archive/${SNAPSHOT}/xset-${SNAPSHOT}.tar.bz2 -> xset-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xset-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-tools/util-macros
	xgui-lib/libX11
	xgui-lib/libXmu
	xgui-lib/libXext"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--without-xf86misc
		--without-fontcache
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
