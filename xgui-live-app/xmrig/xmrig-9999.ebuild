# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR=emake

inherit cmake git-r3

DESCRIPTION="RandomX, CryptoNight, AstroBWT and Argon2 CPU/GPU miner"
HOMEPAGE="https://xmrig.com/"
EGIT_REPO_URI="https://github.com/xmrig/xmrig.git"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="http"

DEPEND="app-misc/hwloc"

src_prepare() {
	cmake_src_prepare
	sed -i 's/kDefaultDonateLevel\ \=\ 1/kDefaultDonateLevel\ \=\ 0/g' src/donate.h
	sed -i 's/kMinimumDonateLevel\ \=\ 1/kMinimumDonateLevel\ \=\ 0/g' src/donate.h
}

src_configure() {
	local mycmakeargs=(
		-D WITH_HTTP=$(usex http ON OFF)
		-D WITH_CUDA=OFF
	)

	cmake_src_configure
}

src_install() {
	dobin ${WORKDIR}/${P}_build/xmrig
}
