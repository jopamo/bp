# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="C library providing BLAKE2b, BLAKE2s, BLAKE2bp, BLAKE2sp"
HOMEPAGE="https://github.com/BLAKE2/libb2"

SNAPSHOT=643decfbf8ae600c3387686754d74c84144950d1
SRC_URI="https://github.com/BLAKE2/libb2/archive/${SNAPSHOT}.tar.gz -> libb2-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libb2-${SNAPSHOT}"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static native-cflags"

filter-flags -Wl,-z,defs

src_prepare() {
	default
	sed -i -e 's/ == / = /' configure.ac || die
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static) \
		$(use_enable native-cflags native)
}

src_compile() {
	emake $(use native-cflags && echo no)CFLAGS="${CFLAGS}"
}
