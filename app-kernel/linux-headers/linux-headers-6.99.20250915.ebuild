# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="master"

ETYPE="headers"
H_SUPPORTEDARCH="amd64 arm64"
inherit kernel-2
SNAPSHOT=46a51f4f5edade43ba66b3c151f0e25ec8b69cb6
SRC_URI="https://github.com/torvalds/linux/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/linux-${SNAPSHOT}"

KEYWORDS="amd64 arm64"
SLOT="0"

[[ -n ${PATCH_VER} ]] && PATCHES=( "${WORKDIR}"/${PATCH_PV} )

src_prepare() {
	use elibc_musl && PATCHES+=(
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
