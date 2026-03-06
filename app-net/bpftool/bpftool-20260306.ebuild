# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Tool for inspection and simple manipulation of eBPF programs and maps"
HOMEPAGE="https://github.com/libbpf/bpftool"
SNAPSHOT=45a3320991b7aab5096493ec40ac49cd0c678f99
SRC_URI="https://github.com/libbpf/bpftool/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="|| ( GPL-2 BSD-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps clang llvm"

BDEPEND="dev-python/docutils"
DEPEND="
	lib-net/libbpf:=[static-libs]
	lib-core/elfutils
	virtual/ssl:0=
	caps? ( lib-core/libcap )
	clang? ( app-build/clang )
	llvm? ( app-build/llvm:= )
"
RDEPEND="${DEPEND}"

CONFIG_CHECK="~DEBUG_INFO_BTF"

src_prepare() {
	default

	# remove -Werror from bpftool feature detection
	sed -i -e 's/-Werror//g' src/Makefile.feature || die

	sed -i -e 's/sbin/bin/g' src/Makefile || die

	# remove hardcoded/unhelpful flags from bpftool
	sed -i -e '/CFLAGS += -O2/d' -e 's/-W //g' -e 's/-Wextra //g' src/Makefile || die

	if ! use clang; then
		# remove bpf target & add assembly annotations to fix CO-RE feature detection
		sed -i -e 's/-target bpf/-dA/' src/Makefile.feature || die

		# remove bpf target from skeleton build
		sed -i -e 's/--target=bpf//g' src/Makefile || die
	fi

	# Use rst2man or rst2man.py depending on which one exists (#930076)
	type -P rst2man >/dev/null || sed -i -e 's/rst2man/rst2man.py/g' docs/Makefile || die
}

bpftool_make() {
	tc-export AR CC LD
	local libbpf_include=${BPFTOOL_LIBBPF_INCLUDE:-${EPREFIX}/usr/include}
	local libbpf_library=${BPFTOOL_LIBBPF_LIBRARY:-${EPREFIX}/usr/lib/libbpf.a}

	emake \
		ARCH="$(tc-arch-kernel)" \
		HOSTAR="$(tc-getBUILD_AR)" \
		HOSTCC="$(tc-getBUILD_CC)" \
		HOSTLD="$(tc-getBUILD_LD)" \
		feature-libcap="$(usex caps 1 0)" \
		feature-llvm="$(usex llvm 1 0)" \
		LIBBPF="${libbpf_library}" \
		LIBBPF_BOOTSTRAP="${libbpf_library}" \
		LIBBPF_INCLUDE="${libbpf_include}" \
		LIBBPF_BOOTSTRAP_INCLUDE="${libbpf_include}" \
		LIBBPF_INTERNAL_HDRS= \
		LIBBPF_BOOTSTRAP_INTERNAL_HDRS= \
		prefix="${EPREFIX}"/usr \
		V=1 \
		"$@"
}

src_compile() {
	bpftool_make -C src
	bpftool_make -C docs
}

src_install() {
	bpftool_make DESTDIR="${D}" -C src install
	bpftool_make mandir="${ED}"/usr/share/man -C docs install
}
