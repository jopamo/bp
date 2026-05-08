# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="main"
SNAPSHOT=d6badba25a6d94e083c4d43da4ad458e4fb6b120

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE="headers"

inherit kernel-2

DESCRIPTION="Linux kernel source code tree"
HOMEPAGE="https://kernel.org/"
SRC_URI="https://gitlab.com/pjo/kone/-/archive/${SNAPSHOT}/kone-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/kone-${SNAPSHOT}"

SLOT="0"
KEYWORDS="amd64 arm64"

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
