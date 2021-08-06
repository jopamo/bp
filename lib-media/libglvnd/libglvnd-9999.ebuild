# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3

DESCRIPTION="The GL Vendor-Neutral Dispatch library"
HOMEPAGE="https://github.com/NVIDIA/libglvnd"
EGIT_REPO_URI="https://github.com/NVIDIA/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="x11-live-libs/libX11"

src_configure() {
	local emesonargs=(
		-Dgles1=false
		)
		meson_src_configure
}
