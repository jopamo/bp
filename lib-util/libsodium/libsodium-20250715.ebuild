# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A portable fork of NaCl, a higher-level cryptographic library"
HOMEPAGE="https://github.com/jedisct1/libsodium"
SNAPSHOT=c3905104847c760fa61037aad4373e6a67b41f68
SRC_URI="https://github.com/jedisct1/libsodium/archive/${SNAPSHOT}.tar.gz -> libsodium-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libsodium-${SNAPSHOT}"

EGIT_BRANCH="stable"

LICENSE="ISC"
SLOT="0/23"
KEYWORDS="amd64 arm64"
IUSE="asm minimal static-libs urandom"

PATCHES=( "${FILESDIR}"/libsodium-1.0.10-cpuflags.patch )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf

	econf \
		$(use_enable asm) \
		$(use_enable minimal) \
		$(use_enable !urandom blocking-random) \
		$(use_enable static-libs static) \
		${myconf}
}
