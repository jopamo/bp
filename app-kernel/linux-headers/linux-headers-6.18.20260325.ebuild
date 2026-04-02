# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="linux-$(ver_cut 1-2).y"
SNAPSHOT=dd26ea937ef593a9c47aa4c85296e6b57a5344a1

ETYPE="headers"
H_SUPPORTEDARCH="amd64 arm64"
inherit kernel-2

HOMEPAGE="https://www.kernel.org"
SRC_URI="https://gitlab.com/linux-kernel/stable/-/archive/${SNAPSHOT}/stable-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/stable-${SNAPSHOT}"

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
