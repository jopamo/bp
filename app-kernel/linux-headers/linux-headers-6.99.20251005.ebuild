# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="master"

ETYPE="headers"
H_SUPPORTEDARCH="amd64 arm64"
inherit kernel-2
SNAPSHOT=7a405dbb0f036f8d1713ab9e7df0cd3137987b07
SRC_URI="https://github.com/torvalds/linux/archive/${SNAPSHOT}.tar.gz -> linux-${SNAPSHOT}.tar.gz"
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
