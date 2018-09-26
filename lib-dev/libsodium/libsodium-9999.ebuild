# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils autotools git-r3

DESCRIPTION="A portable fork of NaCl, a higher-level cryptographic library"
HOMEPAGE="https://github.com/jedisct1/libsodium"
EGIT_REPO_URI="https://github.com/jedisct1/libsodium.git"
EGIT_BRANCH="stable"

LICENSE="ISC"
SLOT="0/23"
KEYWORDS="amd64 arm64 x86"
IUSE="+asm minimal static-libs +urandom cpu_flags_x86_sse4_1 cpu_flags_x86_aes"

PATCHES=( "${FILESDIR}"/${PN}-1.0.10-cpuflags.patch )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf

	# --disable-pie needed on x86, bug #512734
	use x86 && myconf="${myconf} --disable-pie"

	econf \
		$(use_enable asm) \
		$(use_enable minimal) \
		$(use_enable !urandom blocking-random) \
		$(use_enable static-libs static) \
		$(use_enable cpu_flags_x86_sse4_1 sse4_1) \
		$(use_enable cpu_flags_x86_aes aesni) \
		${myconf}
}

src_install() {
	default
	prune_libtool_files
}
