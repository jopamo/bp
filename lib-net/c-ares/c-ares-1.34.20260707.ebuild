# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="v$(ver_cut 1-2)"

inherit cmake qa-policy

DESCRIPTION="C library that resolves names asynchronously"
HOMEPAGE="https://c-ares.haxx.se/"

SNAPSHOT=c7a3138dcfe3bb0eaaf10c0c24c36dc66dc790ab
SRC_URI="https://github.com/c-ares/c-ares/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/c-ares-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_configure() {
	qa-policy-configure

	local mycmakeargs=(
		-DCARES_SHARED=ON
		-DCARES_STATIC=$(usex static-libs ON OFF)
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
	qa-policy-install
}
