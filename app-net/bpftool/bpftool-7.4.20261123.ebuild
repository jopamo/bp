# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs

DESCRIPTION="Tool for inspection and simple manipulation of eBPF programs and maps"
HOMEPAGE="https://github.com/libbpf/bpftool"
BRANCH_NAME="snapshot"
SNAPSHOT=41b7826b2fa9213f494c08bddf8d89d501b2270e
SRC_URI="https://github.com/jopamo/k1g4/archive/${SNAPSHOT}.tar.gz -> k1g4-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/k1g4-${SNAPSHOT}"

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

bpftool_make() {
	tc-export AR CC LD
	local -a feature_tests=( libelf-zstd )
	local -a feature_display=()
	local rst2man

	rst2man=$(type -P rst2man || type -P rst2man.py) || die "rst2man not found"

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
		SKIP_BPF_SKELS="$(usex clang 0 1)" \
		WERROR=0 \
		OPTIMIZATION= \
		WARNINGS='-Wall -Wformat-signedness -Wno-unused-parameter -Wno-missing-field-initializers $(filter-out -Wswitch-enum -Wnested-externs,$(EXTRA_WARNINGS))' \
		RST2MAN="${rst2man}" \
		prefix="${EPREFIX}"/usr \
		sbindir="${EPREFIX}"/usr/bin \
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
