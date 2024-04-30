# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A portable fork of NaCl, a higher-level cryptographic library"
HOMEPAGE="https://github.com/jedisct1/libsodium"

SNAPSHOT=a904cb8aad8f5c9877ef1a5fc4818d3033e390b6
SRC_URI="https://github.com/jedisct1/libsodium/archive/${SNAPSHOT}.tar.gz -> libsodium-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libsodium-${SNAPSHOT}"

EGIT_BRANCH="stable"

LICENSE="ISC"
SLOT="0/23"
KEYWORDS="amd64 arm64"
IUSE="+asm minimal static-libs +urandom"

PATCHES=( "${FILESDIR}"/${PN}-1.0.10-cpuflags.patch )

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
