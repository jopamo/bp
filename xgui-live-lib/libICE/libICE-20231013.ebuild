# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Inter-Client Exchange library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=e8a561b500f7b783d84d81ba158fd28b007745ae
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libICE/-/archive/${SNAPSHOT}/libICE-${SNAPSHOT}.tar.bz2 -> libICE-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libICE-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6 static-libs"

DEPEND="
	lib-dev/libbsd
	xgui-live-lib/xtrans
	xgui-live-app/xorgproto"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		$(use_enable ipv6)
		--disable-docs
		--disable-specs
		--disable-xmlto
		--without-fop
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
