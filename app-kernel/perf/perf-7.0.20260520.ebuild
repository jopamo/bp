# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="snapshot"
SNAPSHOT=6ccfd899b5e6c5140d46b9bcff121a4233bb6b33

DESCRIPTION="Userland tools for Linux Performance Counters"
HOMEPAGE="https://kernel.org/"

SRC_URI="https://gitlab.com/pjo/kone/-/archive/${SNAPSHOT}/kone-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/kone-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+bfd bpf +capstone debug"
RESTRICT="debug? ( strip )"

DEPEND="
	app-kernel/libtraceevent
	capstone? ( app-emu/capstone )
	lib-core/elfutils
	lib-core/zlib
	app-compression/xz-utils
	app-compression/zstd
	bfd? ( app-build/binutils )
	bpf? ( lib-net/libbpf:= )
"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	# fix missing arch asm headers in the tools header layer for this snapshot
	local ksrc=${S}
	local perf_arch=${ARCH}
	local tools_asm_dir
	local hdr

	[[ -n ${perf_arch} ]] || perf_arch=$(uname -m)

	case ${perf_arch} in
		amd64|x86_64)
			perf_arch=x86
			;;
		aarch64)
			perf_arch=arm64
			;;
	esac

	tools_asm_dir=${ksrc}/tools/arch/${perf_arch}/include/asm

	if [[ -d ${tools_asm_dir} ]] && [[ -d ${ksrc}/tools/include/asm ]] ; then
		for hdr in "${tools_asm_dir}"/* ; do
			[[ -e ${hdr} ]] || continue
			[[ -e ${ksrc}/tools/include/asm/${hdr##*/} ]] && continue
			ln -sf ../../arch/${perf_arch}/include/asm/${hdr##*/} \
				"${ksrc}"/tools/include/asm/${hdr##*/} || die
		done
	fi

	# retain libstdc++ for the final perf link under global --as-needed/LTO
	# so __cxa_demangle stays resolved even when libbfd/libiberty are linked
	sed -i \
		-e 's|\$(PERF_IN) \$(LIBS) -o \$@|$(PERF_IN) $(LIBS) -Wl,--push-state,--no-as-needed -lstdc++ -Wl,--pop-state -o $@|' \
		tools/perf/Makefile.perf || die
}

src_compile() {
	local perf_arch=${ARCH}
	local perf_timestamp=${SOURCE_DATE_EPOCH:+@${SOURCE_DATE_EPOCH}}

	[[ -n ${perf_arch} ]] || perf_arch=$(uname -m)

	case ${perf_arch} in
		amd64|x86_64)
			perf_arch=x86
			;;
		arm64|aarch64)
			perf_arch=arm64
			;;
	esac

	[[ -n ${perf_timestamp} ]] || perf_timestamp='1970-01-01 00:00:00 +0000'

	local myemake=(
		ARCH=${perf_arch}
		WERROR=0
		KBUILD_BUILD_TIMESTAMP="${perf_timestamp}"
		# this snapshot's rust-backed test workload is broken and rust support
		# only gates optional perf test workloads here, not the perf tool itself
		NO_RUST=1
		NO_AIO=1
		NO_GTK2=1
		NO_JVMTI=1
		NO_LIBBABELTRACE=1
		NO_LIBDEBUGINFOD=1
		NO_LIBLLVM=1
		NO_LIBNUMA=1
		NO_LIBPFM4=1
		NO_LIBPYTHON=1
		NO_LIBUNWIND=1
		NO_SDT=1
		NO_SLANG=1
		BUILD_BPF_SKEL=0
	)

	if ! use bfd ; then
		myemake+=( NO_LIBBFD=1 )
	fi

	if ! use bpf ; then
		myemake+=( NO_LIBBPF=1 )
	else
		myemake+=( LIBBPF_DYNAMIC=1 )
	fi

	if ! use capstone ; then
		myemake+=( NO_CAPSTONE=1 )
	fi

	if use debug ; then
		myemake+=(
			EXTRA_CFLAGS="-Og -g3 -ggdb3 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer"
			STRIP=true
		)
	fi

	emake -C tools/perf "${myemake[@]}" || die
}

src_install() {
	local perf_arch=${ARCH}
	local perf_timestamp=${SOURCE_DATE_EPOCH:+@${SOURCE_DATE_EPOCH}}

	[[ -n ${perf_arch} ]] || perf_arch=$(uname -m)

	case ${perf_arch} in
		amd64|x86_64)
			perf_arch=x86
			;;
		arm64|aarch64)
			perf_arch=arm64
			;;
	esac

	[[ -n ${perf_timestamp} ]] || perf_timestamp='1970-01-01 00:00:00 +0000'

	local myemake=(
		ARCH=${perf_arch}
		WERROR=0
		KBUILD_BUILD_TIMESTAMP="${perf_timestamp}"
		# keep install in lockstep with compile feature selection
		NO_RUST=1
		NO_AIO=1
		NO_GTK2=1
		NO_JVMTI=1
		NO_LIBBABELTRACE=1
		NO_LIBDEBUGINFOD=1
		NO_LIBLLVM=1
		NO_LIBNUMA=1
		NO_LIBPFM4=1
		NO_LIBPYTHON=1
		NO_LIBUNWIND=1
		NO_SDT=1
		NO_SLANG=1
		BUILD_BPF_SKEL=0
	)

	if ! use bfd ; then
		myemake+=( NO_LIBBFD=1 )
	fi

	if ! use bpf ; then
		myemake+=( NO_LIBBPF=1 )
	else
		myemake+=( LIBBPF_DYNAMIC=1 )
	fi

	if ! use capstone ; then
		myemake+=( NO_CAPSTONE=1 )
	fi

	if use debug ; then
		myemake+=(
			EXTRA_CFLAGS="-Og -g3 -ggdb3 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer"
			STRIP=true
		)
	fi

	emake -C tools/perf install \
		"${myemake[@]}" \
		DESTDIR="${D}" \
		prefix=/usr \
		STRIP=true || die
}
