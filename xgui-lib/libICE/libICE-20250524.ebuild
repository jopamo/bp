# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Inter-Client Exchange library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=513399df5206f52db92bb88970f38dc8a3ea1645
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libICE/-/archive/${SNAPSHOT}/libICE-${SNAPSHOT}.tar.bz2 -> libICE-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libice-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6 static-libs"

DEPEND="
	xgui-lib/xtrans
	xgui-tools/xorgproto
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		$(use_enable ipv6)
		--disable-docs
		--disable-specs
		--without-fop
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
