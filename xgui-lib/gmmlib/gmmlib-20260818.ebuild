# Distributed under the terms of the GNU General Public License v2

inherit cmake qa-policy

DESCRIPTION="Intel Graphics Memory Management Library"
HOMEPAGE="https://github.com/intel/gmmlib"
SNAPSHOT=757922744cc32f247ab4ac31416c32edb57624c7
SRC_URI="https://github.com/intel/gmmlib/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/gmmlib-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

src_configure() {
	qa-policy-configure

	local mycmakeargs=(
		-DRUN_TEST_SUITE=OFF
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	qa-policy-install
}
