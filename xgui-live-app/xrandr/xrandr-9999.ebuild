# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="primitive command line interface to RandR extension"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/app/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND=">=xgui-live-lib/libXrandr-1.5
	xgui-live-lib/libXrender
	xgui-live-lib/libX11"

src_prepare() {
	default
	eautoreconf
}
