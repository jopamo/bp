# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="window information utility for X"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=5306785506f978fa92cc62ad0a9f0d6f073bdb80
SRC_URI="https://gitlab.freedesktop.org/xorg/app/xwininfo/-/archive/${SNAPSHOT}/xwininfo-${SNAPSHOT}.tar.bz2 -> xwininfo-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xwininfo-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="xgui-lib/libxcb"
DEPEND="${RDEPEND}
	xgui-lib/libX11
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
