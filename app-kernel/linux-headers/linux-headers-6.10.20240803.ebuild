# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT="d29de02effd4e8816333582ed8230d41e14a73dc"

ETYPE="headers"
H_SUPPORTEDARCH="amd64 arm64"
inherit kernel-2
detect_version

SRC_URI="https://gitlab.com/linux-kernel/stable/-/archive/${SNAPSHOT}/stable-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
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
