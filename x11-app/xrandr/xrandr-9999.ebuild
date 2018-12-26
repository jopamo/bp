# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="primitive command line interface to RandR extension"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/app/xrandr"

SLOT=0
KEYWORDS="amd64 arm64 x86"

DEPEND=">=x11-libs/libXrandr-1.5
	x11-libs/libXrender
	x11-libs/libX11"

src_prepare() {
	default
	eautoreconf
}
