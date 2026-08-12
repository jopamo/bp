# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="window information utility for X"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=627235a304fcafc450045412c780c94a44a00031
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
		--sbindir="${EPREFIX}"/usr/bin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
