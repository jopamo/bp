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
RDEPEND="${DEPEND}"

src_configure() {
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
