# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR=emake

inherit cmake-utils git-r3 flag-o-matic

DESCRIPTION="RandomX, CryptoNight, AstroBWT and Argon2 CPU/GPU miner"
HOMEPAGE="https://xmrig.com/"
EGIT_REPO_URI="https://github.com/xmrig/xmrig.git"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="cuda http"

DEPEND="sys-app/hwloc"

filter-flags -flto\=\*

src_prepare() {
	cmake-utils_src_prepare
	sed -i 's/kDefaultDonateLevel\ \=\ 5/kDefaultDonateLevel\ \=\ 0/g' src/donate.h
	sed -i 's/kMinimumDonateLevel\ \=\ 1/kMinimumDonateLevel\ \=\ 0/g' src/donate.h
}

src_configure() {
	local mycmakeargs=(
		-D WITH_HTTP=$(usex http)
		-D WITH_CUDA=$(usex cuda)
	)

	cmake-utils_src_configure
}

src_install() {
	dobin ${WORKDIR}/${P}_build/xmrig
}
