# Distributed under the terms of the GNU General Public License v2

EAPI=6

SNAPSHOT="8-20180921"

inherit toolchain

KEYWORDS="amd64 arm64 x86"

RDEPEND=""
DEPEND="${RDEPEND}
	elibc_glibc? ( >=lib-sys/glibc-2.13 )
	>=${CATEGORY}/binutils-2.20"

if [[ ${CATEGORY} != cross-* ]] ; then
	PDEPEND="${PDEPEND} elibc_glibc? ( >=lib-sys/glibc-2.13 )"
fi

src_prepare() {
	toolchain_src_prepare
}
