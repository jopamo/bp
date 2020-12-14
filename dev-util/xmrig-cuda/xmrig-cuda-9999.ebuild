# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="NVIDIA CUDA plugin for XMRig"
HOMEPAGE="https://xmrig.com/"
EGIT_REPO_URI="https://github.com/xmrig/xmrig-cuda.git"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="<sys-devel/gcc-10.0.0"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_C_COMPILER=gcc-9
		-DCMAKE_CXX_COMPILER=gcc++9
	)

	cmake_src_configure
}
