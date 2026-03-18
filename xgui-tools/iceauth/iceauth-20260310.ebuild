# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="ICE authority file utility"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=bbbd5ead211f0bab8dd2341ae7d8e30565843676
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
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
