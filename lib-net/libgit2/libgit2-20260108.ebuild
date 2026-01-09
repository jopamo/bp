# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Portable, pure-library implementation of core Git functionality"
HOMEPAGE="https://www.libgit2.org/"
SNAPSHOT=dff04d9dcc4f0212ab1050c35d6eb2b846d3f7f4
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
