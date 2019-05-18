# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3

DESCRIPTION="A portable fork of NaCl, a higher-level cryptographic library"
HOMEPAGE="https://github.com/jedisct1/libsodium"
EGIT_REPO_URI="https://github.com/jedisct1/libsodium.git"
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
