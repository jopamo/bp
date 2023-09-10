# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT="920a115bf536f33cabd326b7d711b76609b96af1"

ETYPE="headers"
H_SUPPORTEDARCH="amd64 arm64"
inherit kernel-2
detect_version

PATCH_PV=$(ver_cut 1-2) # to ease testing new versions against not existing patches
PATCH_VER="1"
PATCH_DEV="sam"

SRC_URI="
	https://gitlab.com/linux-kernel/stable/-/archive/${SNAPSHOT}/stable-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2
	${PATCH_VER:+https://dev.gentoo.org/~${PATCH_DEV}/distfiles/sys-kernel/linux-headers/gentoo-headers-${PATCH_PV}-${PATCH_VER}.tar.xz}
"
S="${WORKDIR}/stable-${SNAPSHOT}"

KEYWORDS="amd64 arm64"

IUSE="musl"

[[ -n ${PATCH_VER} ]] && PATCHES=( "${WORKDIR}"/${PATCH_PV} )

src_unpack() {
	# Avoid kernel-2_src_unpack
	default
}

src_prepare() {
	use musl && PATCHES+=(
		"${FILESDIR}"/${PN}-5.15-remove-inclusion-sysinfo.h.patch
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
