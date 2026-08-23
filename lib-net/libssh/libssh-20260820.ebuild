# Distributed under the terms of the GNU General Public License v2

inherit cmake multibuild qa-policy

DESCRIPTION="Library implementing the SSH2 protocol"
HOMEPAGE="http://www.libssh.org/"
SNAPSHOT=04979babae0e626ab32c81876b97cf22ef926d14
SRC_URI="https://gitlab.com/libssh/libssh-mirror/-/archive/${SNAPSHOT}/libssh-mirror-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libssh-mirror-${SNAPSHOT}"
PATCHES=(
	"${FILESDIR}/${PN}-sntrup761-maybe-uninitialized.patch"
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
