# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Display information utility for X"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=f579f7e654be0792294a299a32cc0d6f80d74e7e
SRC_URI="https://gitlab.freedesktop.org/xorg/app/xdpyinfo/-/archive/${SNAPSHOT}/xdpyinfo-${SNAPSHOT}.tar.bz2 -> xdpyinfo-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xdpyinfo-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="dga dmx xinerama"

RDEPEND="
	xgui-lib/libX11
	xgui-lib/libXcomposite
	xgui-lib/libXext
	xgui-lib/libXi
	xgui-lib/libXrender
	xgui-lib/libXtst
	xgui-lib/libXxf86vm
	xgui-lib/libxcb
	dga? ( xgui-live-lib/libXxf86dga )
	dmx? ( xgui-live-lib/libdmx )
	xinerama? ( xgui-lib/libXinerama )
"
DEPEND="${RDEPEND}
	xgui-tools/xorgproto
"

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
		--without-xf86misc
		$(use_with dga)
		$(use_with dmx)
		$(use_with xinerama)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
