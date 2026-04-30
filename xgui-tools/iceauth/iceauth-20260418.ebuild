# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="ICE authority file utility"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=dd8a8dbe100d6427c01605da0a69a74fa36ddc87
SRC_URI="https://gitlab.freedesktop.org/xorg/app/iceauth/-/archive/${SNAPSHOT}/iceauth-${SNAPSHOT}.tar.bz2 -> iceauth-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/iceauth-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="xgui-lib/libICE"
DEPEND="${RDEPEND}
	xgui-tools/xorgproto"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/bin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
