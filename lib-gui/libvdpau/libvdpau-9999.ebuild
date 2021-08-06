# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic git-r3 meson

DESCRIPTION="VDPAU wrapper and trace libraries"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/VDPAU"
EGIT_REPO_URI="https://gitlab.freedesktop.org/vdpau/${PN}/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="dri"

RDEPEND="
	x11-live-libs/libX11
	dri? ( x11-live-libs/libXext )
"
DEPEND="
	${RDEPEND}
	dev-util/pkgconf
	dri? ( x11-live-misc/xorgproto )
"

src_configure() {
	append-cppflags -D_GNU_SOURCE

	local emesonargs=(
		-Ddri2=$(usex dri true false)
		-Ddocumentation=false
	)
	meson_src_configure
}
