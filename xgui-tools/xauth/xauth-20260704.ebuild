# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="X authority file utility"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=06c39dd0f7e19950e835a062edee8a2272e3270c
SRC_URI="https://gitlab.freedesktop.org/xorg/app/xauth/-/archive/${SNAPSHOT}/xauth-${SNAPSHOT}.tar.bz2 -> xauth-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xauth-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6"

DEPEND="xgui-lib/libX11
	xgui-lib/libXau
	xgui-lib/libXext
	xgui-lib/libXmu"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable ipv6)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
