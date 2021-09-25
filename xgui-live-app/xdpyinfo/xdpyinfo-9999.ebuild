# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="Display information utility for X"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/app/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="dga dmx xinerama"

RDEPEND="
	xgui-live-lib/libX11
	xgui-live-lib/libXcomposite
	xgui-live-lib/libXext
	xgui-live-lib/libXi
	xgui-live-lib/libXrender
	xgui-live-lib/libXtst
	xgui-live-lib/libXxf86vm
	xgui-live-lib/libxcb
	dga? ( xgui-live-lib/libXxf86dga )
	dmx? ( xgui-live-lib/libdmx )
	xinerama? ( xgui-live-lib/libXinerama )
"
DEPEND="${RDEPEND}
	xgui-live-app/xorgproto
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
