# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR=emake

inherit cmake

DESCRIPTION="RandomX, CryptoNight, AstroBWT and Argon2 CPU/GPU miner"
HOMEPAGE="https://xmrig.com/"
SNAPSHOT=6e4a5a6d94b33d6ed93890126c699b62f9553f50
SRC_URI="https://github.com/xmrig/xmrig/archive/${SNAPSHOT}.tar.gz -> xmrig-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/xmrig-${SNAPSHOT}"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="http"

DEPEND="app-var/hwloc"

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
