# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake multibuild qa-policy

DESCRIPTION="Library implementing the SSH2 protocol"
HOMEPAGE="http://www.libssh.org/"
SNAPSHOT=90b07e2c18ba3a36ce842c4828407f72fb390c55
SRC_URI="https://git.libssh.org/projects/libssh.git/snapshot/libssh-${SNAPSHOT}.tar.xz"
S="${WORKDIR}/libssh-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

pkg_setup() {
	MULTIBUILD_VARIANTS=( $(usev static-libs) shared )
}

src_configure() {
	myconfigure() {
		local QA_POLICY_LTO_FLAVOR=none
		local mycmakeargs=()

		if [[ ${MULTIBUILD_VARIANT} = static-libs ]]; then
			QA_POLICY_LTO_FLAVOR=fat+strip
			mycmakeargs+=(
				-DBUILD_SHARED_LIBS=OFF
			)
		else
			mycmakeargs+=(
				-DBUILD_SHARED_LIBS=ON
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

src_install() {
	multibuild_foreach_variant cmake_src_install
	qa-policy-install
}
