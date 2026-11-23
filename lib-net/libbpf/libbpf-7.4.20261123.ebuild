# Distributed under the terms of the GNU General Public License v2

inherit flag-o-matic toolchain-funcs qa-policy

DESCRIPTION="Stand-alone build of libbpf from the Linux kernel"
HOMEPAGE="https://github.com/libbpf/libbpf"
BRANCH_NAME="snapshot"
SNAPSHOT=7d467b3b7186f139d58c4ed76b9a2c299f451984
SRC_URI="https://github.com/jopamo/k1g4/archive/${SNAPSHOT}.tar.gz -> k1g4-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/k1g4-${SNAPSHOT}/tools/lib/bpf"

LICENSE="GPL-2 LGPL-2.1 BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"
BDEPEND="app-dev/patchelf"
DEPEND="
	lib-core/elfutils
	lib-core/zlib
"
RDEPEND="${DEPEND}"

libbpf_emake() {
	emake \
		prefix="${EPREFIX}/usr" \
		libdir="${EPREFIX}/usr/lib" \
		INSTALL_INTERNAL_HEADERS=1 \
		INSTALL_UAPI_HEADERS=1 \
		WERROR=0 \
		V=1 \
		"$@"
}

src_configure() {
	qa-policy-configure

	append-cflags -fPIC
	tc-export CC AR LD PKG_CONFIG
}

src_compile() {
	libbpf_emake
}

src_install() {
	libbpf_emake DESTDIR="${D}" install

	if ! use static-libs; then
		find "${ED}" -name '*.a' -delete || die
	fi

	qa-policy-install
}
