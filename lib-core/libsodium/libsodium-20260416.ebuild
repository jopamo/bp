# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="stable"

inherit autotools qa-policy

DESCRIPTION="A portable fork of NaCl, a higher-level cryptographic library"
HOMEPAGE="https://github.com/jedisct1/libsodium"

SNAPSHOT=33cc75ab1565d9dcbe808354191bd572ad6b64d0
SRC_URI="https://github.com/jedisct1/libsodium/archive/${SNAPSHOT}.tar.gz -> libsodium-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libsodium-${SNAPSHOT}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="asm minimal static-libs urandom"

PATCHES=( "${FILESDIR}"/libsodium-1.0.10-cpuflags.patch )

src_prepare() {
	qa-policy-configure
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

src_install() {
	default
	qa-policy-install
}
