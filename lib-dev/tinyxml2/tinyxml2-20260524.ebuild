# Distributed under the terms of the GNU General Public License v2

inherit cmake multibuild qa-policy

DESCRIPTION="A simple, small, efficient, C++ XML parser"
HOMEPAGE="https://www.grinninglizard.com/tinyxml2/ https://github.com/leethomason/tinyxml2/"
SNAPSHOT=8224e427b655b83dae5e2298f1e6919523a78737
SRC_URI="https://github.com/leethomason/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="ZLIB"
SLOT="0/11"
KEYWORDS="amd64 arm64"
IUSE="static-libs test"

pkg_setup() {
	MULTIBUILD_VARIANTS=( shared $(usev static-libs) )
}

src_configure() {
	myconfigure() {
		local QA_POLICY_LTO_FLAVOR=none
		local mycmakeargs=()

		if [[ ${MULTIBUILD_VARIANT} = static-libs ]]; then
			QA_POLICY_LTO_FLAVOR=fat+strip
			mycmakeargs+=(
				-DBUILD_SHARED_LIBS=OFF
				-Dtinyxml2_BUILD_TESTING=OFF
			)
		else
			mycmakeargs+=(
				-DBUILD_SHARED_LIBS=ON
				-Dtinyxml2_BUILD_TESTING=$(usex test)
			)
		fi

		qa-policy-configure
		cmake_src_configure
	}

	multibuild_foreach_variant myconfigure
}

src_compile() {
	multibuild_foreach_variant cmake_src_compile
}

src_test() {
	run_tests() {
		[[ ${MULTIBUILD_VARIANT} = shared ]] && cmake_src_test
	}

	multibuild_foreach_variant run_tests
}

src_install() {
	multibuild_foreach_variant cmake_src_install
	qa-policy-install
}
