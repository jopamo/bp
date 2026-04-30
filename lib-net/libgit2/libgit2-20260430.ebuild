# Distributed under the terms of the GNU General Public License v2

inherit cmake flag-o-matic

DESCRIPTION="Portable, pure-library implementation of core Git functionality"
HOMEPAGE="https://www.libgit2.org/"
SNAPSHOT=cefc409a97db3681bcebce4af39a685934364404
SRC_URI="https://github.com/libgit2/libgit2/archive/${SNAPSHOT}.tar.gz -> libgit2-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/libgit2-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	append-flags -ffat-lto-objects

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
	)
	cmake_src_configure
}
