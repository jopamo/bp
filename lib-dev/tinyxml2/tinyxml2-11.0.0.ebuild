# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake multibuild qa-policy

DESCRIPTION="A simple, small, efficient, C++ XML parser"
HOMEPAGE="http://www.grinninglizard.com/tinyxml2/ https://github.com/leethomason/tinyxml2/"
SRC_URI="https://github.com/leethomason/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0/6"
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
