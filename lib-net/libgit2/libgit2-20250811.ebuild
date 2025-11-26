# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Portable, pure-library implementation of core Git functionality"
HOMEPAGE="https://www.libgit2.org/"
SNAPSHOT=58d9363f02f1fa39e46d49b604f27008e75b72f2
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
