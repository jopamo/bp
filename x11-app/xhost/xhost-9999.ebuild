# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="uncompile an rgb color-name database"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/app/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	x11-live-libs/libXmu
	x11-live-libs/libX11
"

src_prepare() {
	eautoreconf
	default
}
