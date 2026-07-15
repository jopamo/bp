# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Display information utility for X"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=80d576e87a198a509b60d9aae1032e42fc7065da
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

src_configure() {
	local emesonargs=(
		-Dxf86misc=disabled
		$(meson_feature dga)
		$(meson_feature dmx)
		$(meson_feature xinerama)
	)

	meson_src_configure
}
