# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 flag-o-matic

DESCRIPTION="Ethereum miner with CUDA and stratum support"
HOMEPAGE="https://github.com/ethereum-mining/ethminer"
EGIT_REPO_URI="https://github.com/ethereum-mining/${PN}.git"

SRC_URI="https://boostorg.jfrog.io/artifactory/main/release/1.66.0/source/boost_1_66_0.7z"

LICENSE="GPL-3+ LGPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

QA_PREBUILT="usr/bin/kernels/ethash_*"

filter-flags -Wl,-z,defs -flto\=\*

src_prepare() {
	mkdir -p "${HOME}"/.hunter/_Base/Download/Boost/1.66.0/075d0b4/
	cp "${DISTDIR}"/boost_1_66_0.7z "${HOME}"/.hunter/_Base/Download/Boost/1.66.0/075d0b4/boost_1_66_0.7z
	default
	mkdir build
}

src_configure() {
	cd build
	cmake .. -DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr -DCMAKE_BUILD_TYPE=Release
}

src_compile() {
	cd build
	cmake --build .
}

src_install() {
	cd build
	emake DESTDIR=${ED} install
}
