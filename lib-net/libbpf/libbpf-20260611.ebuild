# Distributed under the terms of the GNU General Public License v2

inherit flag-o-matic toolchain-funcs qa-policy

DESCRIPTION="Stand-alone build of libbpf from the Linux kernel"
HOMEPAGE="https://github.com/libbpf/libbpf"
SNAPSHOT=cc6316e9d1cc563ad34a5ff474a24fc123270e8d
SRC_URI="https://gitlab.com/pjo/kone/-/archive/${SNAPSHOT}/kone-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/kone-${SNAPSHOT}/tools/lib/bpf"

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

src_prepare() {
	default

	sed -i -e 's/-Werror//g' Makefile || die
}

libbpf_emake() {
	emake \
		prefix="${EPREFIX}/usr" \
		libdir="${EPREFIX}/usr/lib" \
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
	local ksrc=${WORKDIR}/kone-${SNAPSHOT}

	libbpf_emake DESTDIR="${D}" install

	# bpftool consumes these libbpf internal headers during its own build.
	insinto /usr/include/bpf
	doins hashmap.h nlattr.h relo_core.h libbpf_internal.h

	insinto /usr/include/bpf/uapi/linux
	doins \
		"${ksrc}"/tools/include/uapi/linux/bpf.h \
		"${ksrc}"/tools/include/uapi/linux/bpf_common.h \
		"${ksrc}"/tools/include/uapi/linux/btf.h

	sed -i \
		-e '/^includedir=/a uapidir=${prefix}/include/bpf/uapi' \
		-e 's#^Cflags: .*#Cflags: -I${includedir} -I${uapidir}#' \
		"${ED}/usr/lib/pkgconfig/libbpf.pc" || die

	if ! use static-libs; then
		find "${ED}" -name '*.a' -delete || die
	fi

	qa-policy-install
}
