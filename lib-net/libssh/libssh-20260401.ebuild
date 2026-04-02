# Distributed under the terms of the GNU General Public License v2

inherit cmake multibuild qa-policy

DESCRIPTION="Library implementing the SSH2 protocol"
HOMEPAGE="http://www.libssh.org/"
SNAPSHOT=08c7d67face0e504ae52a021206c3002f991d600
SRC_URI="https://git.libssh.org/projects/libssh.git/snapshot/libssh-${SNAPSHOT}.tar.xz"
S="${WORKDIR}/libssh-${SNAPSHOT}"
PATCHES=(
	"${FILESDIR}/${P}-sntrup761-maybe-uninitialized.patch"
)

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

	local QA_POLICY_ARCHIVE_DUPLICATE_MEMBER_ALLOW="
		/usr/lib/libssh.a:libcrypto.c.o
		/usr/lib/libssh.a:sntrup761.c.o
	"

	qa-policy-install
}
