# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="linux-$(ver_cut 1-2).y"
SNAPSHOT=25e0b1c206e3def1bd3bf9dcba980c5138c637a9

DESCRIPTION="Userland tools for Linux Performance Counters"
HOMEPAGE="https://kernel.org/"

SRC_URI="https://gitlab.com/linux-kernel/stable/-/archive/${SNAPSHOT}/stable-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/stable-${SNAPSHOT}/tools/perf"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bpf debug"
RESTRICT="debug? ( strip )"

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
}

src_compile() {
	local perf_arch

	case ${ARCH} in
		amd64)
			perf_arch=x86
			;;
		arm64)
			perf_arch=arm64
			;;
		*)
			perf_arch=${ARCH}
			;;
	esac

	local myemake=(
		ARCH=${perf_arch}
		WERROR=0
		NO_LIBTRACEEVENT=1
	)

	if ! use bpf ; then
		myemake+=( NO_LIBBPF=1 )
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
	local perf_arch

	case ${ARCH} in
		amd64)
			perf_arch=x86
			;;
		arm64)
			perf_arch=arm64
			;;
		*)
			perf_arch=${ARCH}
			;;
	esac

	local myemake=(
		ARCH=${perf_arch}
		WERROR=0
		NO_LIBTRACEEVENT=1
	)

	if ! use bpf ; then
		myemake+=( NO_LIBBPF=1 )
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
