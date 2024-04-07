# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic meson

DESCRIPTION="VDPAU wrapper and trace libraries"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/VDPAU"

SNAPSHOT=2afa3f989af24a922692ac719fae23c321776cdb
SRC_URI="https://gitlab.freedesktop.org/vdpau/libvdpau/-/archive/${SNAPSHOT}/libvdpau-${SNAPSHOT}.tar.bz2 -> libvdpau-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libvdpau-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="dri"

RDEPEND="
	xgui-live-lib/libX11
	dri? ( xgui-live-lib/libXext )
"
DEPEND="
	${RDEPEND}
	app-dev/pkgconf
	dri? ( xgui-live-app/xorgproto )
"

src_configure() {
	append-cppflags -D_GNU_SOURCE

	local emesonargs=(
		-Ddri2=$(usex dri true false)
		-Ddocumentation=false
	)
	meson_src_configure
}
