# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="The GL Vendor-Neutral Dispatch library"
HOMEPAGE="https://github.com/NVIDIA/libglvnd"

SNAPSHOT=908086d22dc307d17d0eb35c522c35fd190718cc
SRC_URI="https://github.com/NVIDIA/libglvnd/archive/${SNAPSHOT}.tar.gz -> libglvnd-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libglvnd-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="xgui-lib/libX11"

src_configure() {
	local emesonargs=(
		-Dgles1=false
		)
		meson_src_configure
}
