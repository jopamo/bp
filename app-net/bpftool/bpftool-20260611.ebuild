# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs

DESCRIPTION="Tool for inspection and simple manipulation of eBPF programs and maps"
HOMEPAGE="https://github.com/libbpf/bpftool"
SNAPSHOT=cc6316e9d1cc563ad34a5ff474a24fc123270e8d
SRC_URI="https://gitlab.com/pjo/kone/-/archive/${SNAPSHOT}/kone-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/kone-${SNAPSHOT}"

LICENSE="|| ( GPL-2 BSD-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps clang llvm"

BDEPEND="dev-pypi/docutils"
DEPEND="
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
	sed -i -e 's/-Werror//g' tools/build/feature/Makefile || die

	sed -i \
		-e 's#/sbin#/bin#g' \
		-e '/CFLAGS += -O2/d' \
		-e '/CFLAGS += -W$/d' \
		-e '/CFLAGS += -Wextra$/d' \
		tools/bpf/bpftool/Makefile || die

	if ! use clang; then
		# remove bpf target & add assembly annotations to fix CO-RE feature detection
		sed -i -e 's/--target=bpf/-dA/g' tools/build/feature/Makefile || die

		# remove bpf target from skeleton build
		sed -i -e 's/--target=bpf//g' tools/bpf/bpftool/Makefile || die
	fi

	# Use rst2man or rst2man.py depending on which one exists (#930076)
	type -P rst2man >/dev/null || \
		sed -i -e 's/rst2man/rst2man.py/g' tools/bpf/bpftool/Documentation/Makefile || die
}

bpftool_make() {
	tc-export AR CC LD
	local -a feature_tests=( libelf-zstd )
	local -a feature_display=()

	use clang && {
		feature_tests+=( clang-bpf-co-re )
		feature_display+=( clang-bpf-co-re )
	}
	use llvm && {
		feature_tests+=( llvm )
		feature_display+=( llvm )
	}
	use caps && {
		feature_tests+=( libcap )
		feature_display+=( libcap )
	}

	emake \
		-C tools/bpf/bpftool \
		ARCH="$(tc-arch-kernel)" \
		HOSTAR="$(tc-getBUILD_AR)" \
		HOSTCC="$(tc-getBUILD_CC)" \
		HOSTLD="$(tc-getBUILD_LD)" \
		FEATURE_TESTS="${feature_tests[*]}" \
		FEATURE_DISPLAY="${feature_display[*]}" \
		feature-libcap="$(usex caps 1 0)" \
		feature-llvm="$(usex llvm 1 0)" \
		prefix="${EPREFIX}"/usr \
		V=1 \
		"$@"
}

src_compile() {
	bpftool_make
	bpftool_make doc
}

src_install() {
	bpftool_make DESTDIR="${D}" install
	bpftool_make DESTDIR="${D}" mandir="${EPREFIX}/usr/share/man" doc-install
}
