# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="primitive command line interface to RandR extension"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/app/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND=">=x11-live-libs/libXrandr-1.5
	x11-live-libs/libXrender
	x11-live-libs/libX11"

src_prepare() {
	default
	eautoreconf
}
