# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Tool for inspection and simple manipulation of eBPF programs and maps"
HOMEPAGE="https://github.com/libbpf/bpftool"
SNAPSHOT=31c371d6cccea95d7d25cd792036efd1bd63a483
SRC_URI="https://github.com/libbpf/bpftool/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="|| ( GPL-2 BSD-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+bfd caps clang llvm"

BDEPEND="dev-py/docutils"
DEPEND="
	lib-net/libbpf:=[static-libs]
	lib-core/elfutils
	virtual/ssl:0=
	bfd? ( app-build/binutils app-compression/zstd )
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

	if use bfd; then
		# keep probe and final libbfd links aligned with modern binutils static deps
		sed -i \
			-e 's/$(call libbfd_build,-lbfd -ldl))/$(call libbfd_build,-lbfd -ldl -lsframe -lzstd -lstdc++))/' \
			-e 's/$(call libbfd_build,-lbfd -ldl -liberty))/$(call libbfd_build,-lbfd -ldl -liberty -lsframe -lzstd -lstdc++))/' \
			-e 's/$(call libbfd_build,-lbfd -ldl -liberty -lz))/$(call libbfd_build,-lbfd -ldl -liberty -lz -lsframe -lzstd -lstdc++))/' \
			src/Makefile.feature || die

		sed -i \
			-e 's/LIBS += -lbfd -ldl -lopcodes$/LIBS += -lbfd -ldl -lopcodes -lsframe -lzstd -lstdc++/' \
			-e 's/LIBS += -lbfd -ldl -lopcodes -liberty$/LIBS += -lbfd -ldl -lopcodes -liberty -lsframe -lzstd -lstdc++/' \
			-e 's/LIBS += -lbfd -ldl -lopcodes -liberty -lz$/LIBS += -lbfd -ldl -lopcodes -liberty -lz -lsframe -lzstd -lstdc++/' \
			src/Makefile || die
	fi

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
	local -a feature_tests=( libelf-zstd )
	local -a feature_display=()

	if use bfd; then
		feature_tests+=( libbfd disassembler-four-args disassembler-init-styled )
		feature_display+=( libbfd )
	fi

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
		ARCH="$(tc-arch-kernel)" \
		HOSTAR="$(tc-getBUILD_AR)" \
		HOSTCC="$(tc-getBUILD_CC)" \
		HOSTLD="$(tc-getBUILD_LD)" \
		FEATURE_TESTS="${feature_tests[*]}" \
		FEATURE_DISPLAY="${feature_display[*]}" \
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
