# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic git-r3 meson

DESCRIPTION="VDPAU wrapper and trace libraries"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/VDPAU"
EGIT_REPO_URI="https://gitlab.freedesktop.org/vdpau/${PN}/"

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
