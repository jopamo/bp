# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="Display information utility for X"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/app/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="dga dmx xinerama"

RDEPEND="
	x11-live-libs/libX11
	x11-live-libs/libXcomposite
	x11-live-libs/libXext
	x11-live-libs/libXi
	x11-live-libs/libXrender
	x11-live-libs/libXtst
	x11-live-libs/libXxf86vm
	lib-gui/libxcb
	dga? ( x11-live-libs/libXxf86dga )
	dmx? ( x11-live-libs/libdmx )
	xinerama? ( x11-live-libs/libXinerama )
"
DEPEND="${RDEPEND}
	x11-live-misc/xorgproto
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
