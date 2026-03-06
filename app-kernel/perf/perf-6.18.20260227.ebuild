# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="linux-$(ver_cut 1-2).y"
SNAPSHOT=df0dc1b06fb6b6461f9838694bf84079eca7562a

DESCRIPTION="Userland tools for Linux Performance Counters"
HOMEPAGE="https://kernel.org/"

SRC_URI="https://gitlab.com/linux-kernel/stable/-/archive/${SNAPSHOT}/stable-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/stable-${SNAPSHOT}/tools/perf"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+bfd bpf debug"
RESTRICT="debug? ( strip )"

DEPEND="
	app-kernel/libtraceevent
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

	# fix missing x86 asm headers in tools header layer for this snapshot
	local ksrc=${WORKDIR}/stable-${SNAPSHOT}

	if [[ -d ${ksrc}/arch/x86/include/asm ]] && [[ -d ${ksrc}/tools/include/asm ]] ; then
		if [[ -f ${ksrc}/arch/x86/include/asm/asm.h ]] ; then
			ln -sf ../../arch/x86/include/asm/asm.h \
				"${ksrc}"/tools/include/asm/asm.h || die
		fi

		if [[ -f ${ksrc}/arch/x86/include/asm/cmpxchg.h ]] ; then
			ln -sf ../../arch/x86/include/asm/cmpxchg.h \
				"${ksrc}"/tools/include/asm/cmpxchg.h || die
		fi
	fi

	# keep libstdc++ retained under global --as-needed so LTO links
	# don't drop __cxa_demangle providers used by demangle-cxx.cpp
	sed -i \
		-e 's/EXTLIBS += -lstdc++/EXTLIBS += -Wl,--no-as-needed -lstdc++ -Wl,--as-needed/g' \
		Makefile.config || die
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
		NO_AIO=1
		NO_CAPSTONE=1
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

	if use debug ; then
		myemake+=(
			EXTRA_CFLAGS="-Og -g3 -ggdb3 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer"
			STRIP=true
		)
	fi

	emake "${myemake[@]}" || die
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
		NO_AIO=1
		NO_CAPSTONE=1
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

	if use debug ; then
		myemake+=(
			EXTRA_CFLAGS="-Og -g3 -ggdb3 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer"
			STRIP=true
		)
	fi

	emake install \
		"${myemake[@]}" \
		DESTDIR="${D}" \
		prefix=/usr \
		STRIP=true || die
}
