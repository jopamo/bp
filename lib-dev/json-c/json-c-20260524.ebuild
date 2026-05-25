# Distributed under the terms of the GNU General Public License v2

inherit cmake qa-policy

DESCRIPTION="A JSON implementation in C"
HOMEPAGE="https://github.com/json-c/json-c/wiki"
SNAPSHOT=3e708e4c4f231f00e91efeb7d2cd1221aac165cb
SRC_URI="https://github.com/json-c/json-c/archive/${SNAPSHOT}.tar.gz -> json-c-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/json-c-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_configure() {
	qa-policy-configure
	export USE_VALGRIND=0

	local mycmakeargs=(
		-DBUILD_APPS=OFF
		-DBUILD_STATIC_LIBS=$(usex static-libs)
		-DDISABLE_EXTRA_LIBS=ON
		-DDISABLE_WERROR=ON
		-DENABLE_RDRAND=ON
		-DENABLE_THREADING=ON
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
	qa-policy-install
}
