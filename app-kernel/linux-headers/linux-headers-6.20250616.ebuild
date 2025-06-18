# Distributed under the terms of the GNU General Public License v2

EAPI=8

ETYPE="headers"
H_SUPPORTEDARCH="amd64 arm64"
inherit kernel-2
detect_version

BRANCH_NAME="master"
SNAPSHOT=9afe652958c3ee88f24df1e4a97f298afce89407
SRC_URI="https://github.com/torvalds/linux/archive/${SNAPSHOT}.tar.gz -> linux-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/linux-${SNAPSHOT}

KEYWORDS="amd64 arm64"

IUSE="musl"

[[ -n ${PATCH_VER} ]] && PATCHES=( "${WORKDIR}"/${PATCH_PV} )

src_unpack() {
	# Avoid kernel-2_src_unpack
	default
}

src_prepare() {
	use musl && PATCHES+=(
		"${FILESDIR}"/linux-headers-5.15-remove-inclusion-sysinfo.h.patch
	)

	# Avoid kernel-2_src_prepare
	default
}

src_install() {
	kernel-2_src_install

	find "${ED}" \( -name '.install' -o -name '*.cmd' \) -delete || die
	# Delete empty directories
	find "${ED}" -empty -type d -delete || die
}
