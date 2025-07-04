# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="linux-$(ver_cut 1-2).y"
SNAPSHOT=e60eb441596d1c70e4a264d2bac726c6cd2da067

ETYPE="headers"
H_SUPPORTEDARCH="amd64 arm64"
inherit kernel-2

SRC_URI="https://gitlab.com/linux-kernel/stable/-/archive/${SNAPSHOT}/stable-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/stable-${SNAPSHOT}"

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
