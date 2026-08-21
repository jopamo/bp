# Distributed under the terms of the GNU General Public License v2

inherit cmake qa-policy

DESCRIPTION="Intel VA-API media driver"
HOMEPAGE="https://github.com/intel/media-driver"
SNAPSHOT=fef2e5e6d7ce5f9fd090c3297ecc3c113519b3a6
SRC_URI="https://github.com/intel/media-driver/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/media-driver-${SNAPSHOT}"

LICENSE="MIT BSD"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	xgui-lib/gmmlib
	xgui-lib/libva
"
BDEPEND="
	app-build/llvm
"
RDEPEND="${DEPEND}"
PATCHES=( "${FILESDIR}"/intel-media-driver-ninja-response-file.patch )

src_configure() {
	# The media-driver include graph is large enough to exceed the compiler
	# subprocess argument budget on both libc families. Clang handles cc1
	# in-process, while GCC must exec cc1plus with the expanded argv.
	local -x CC="clang --target=${CHOST}"
	local -x CXX="clang++ --target=${CHOST}"

	qa-policy-configure

	local mycmakeargs=(
		-DGFX_DEVELOPMENT_DIR="${S}"
		-DENABLE_KERNELS=ON
		-DENABLE_NONFREE_KERNELS=ON
		-DBUILD_KERNELS=OFF
		-DBUILD_CMRTLIB=OFF
		# Keep libva's distro-owned driver path; do not install the
		# upstream /etc/profile.d/intel-media.sh override.
		-DINSTALL_DRIVER_SYSCONF=OFF
		-DLIBVA_DRIVERS_PATH=lib/va/drivers
		-DMEDIA_BUILD_FATAL_WARNINGS=OFF
		-DMEDIA_RUN_TEST_SUITE=OFF
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	qa-policy-install
}
