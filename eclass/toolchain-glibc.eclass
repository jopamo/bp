# Distributed under the terms of the GNU General Public License v2

# @ECLASS: toolchain-glibc.eclass
# @BLURB: Common code for lib-sys/glibc ebuilds
# @DESCRIPTION:
# This eclass contains the common phase functions migrated from
# lib-sys/glibc eblits.

if [[ -z ${_TOOLCHAIN_GLIBC_ECLASS} ]]; then

inherit eutils versionator toolchain-funcs flag-o-matic gnuconfig \
	systemd unpacker multiprocessing prefix

case ${EAPI:-0} in
	0|1|2|34|5)  die "Unsupported EAPI=${EAPI}";;
esac

# == common ==

alt_prefix() {
	is_crosscompile && echo /usr/${CTARGET}
}

# This indirection is for binpkgs. #523332
_nonfatal() { nonfatal "$@" ; }
if [[ ${EAPI:-0} == [0123] ]] ; then
	nonfatal() { "$@" ; }
	_nonfatal() { "$@" ; }
fi

alt_headers() {
	echo ${ALT_HEADERS:=$(alt_prefix)/usr/include}
}
alt_build_headers() {
	if [[ -z ${ALT_BUILD_HEADERS} ]] ; then
		ALT_BUILD_HEADERS="${EPREFIX}$(alt_headers)"
		if tc-is-cross-compiler ; then
			ALT_BUILD_HEADERS=${SYSROOT}$(alt_headers)
			if [[ ! -e ${ALT_BUILD_HEADERS}/linux/version.h ]] ; then
				local header_path=$(echo '#include <linux/version.h>' | $(tc-getCPP ${CTARGET}) ${CFLAGS} 2>&1 | grep -o '[^"]*linux/version.h')
				ALT_BUILD_HEADERS=${header_path%/linux/version.h}
			fi
		fi
	fi
	echo "${ALT_BUILD_HEADERS}"
}

alt_libdir() {
	echo $(alt_prefix)/usr/$(get_libdir)
}
alt_usrlibdir() {
	echo $(alt_prefix)/usr/$(get_libdir)
}

builddir() {
	echo "${WORKDIR}/build-${ABI}-${CTARGET}-$1"
}

setup_target_flags() {
	# This largely mucks with compiler flags.  None of which should matter
	# when building up just the headers.
	just_headers && return 0

	case $(tc-arch) in
		amd64)
			# -march needed for #185404 #199334
			# Note: This test only matters when the x86 ABI is enabled, so we could
			# optimize a bit and elide it.
			# TODO: See cross-compile issues listed above for x86.
			if ! glibc_compile_test "${CFLAGS_x86}" 'void f(int i, void *p) {if (__sync_fetch_and_add(&i, 1)) f(i, p);}\nint main(){return 0;}\n' 2>/dev/null ; then
				local t=${CTARGET_OPT:-${CTARGET}}
				t=${t%%-*}
				# Normally the target is x86_64-xxx, so turn that into the -march that
				# gcc actually accepts. #528708
				[[ ${t} == "x86_64" ]] && t="x86-64"
				filter-flags '-march=*'
				# ugly, ugly, ugly.  ugly.
				CFLAGS_x86=$(CFLAGS=${CFLAGS_x86} filter-flags '-march=*'; echo "${CFLAGS}")
				export CFLAGS_x86="${CFLAGS_x86} -march=${t}"
				einfo "Auto adding -march=${t} to CFLAGS_x86 #185404"
			fi
		;;
	esac
}

setup_flags() {
	# Make sure host make.conf doesn't pollute us
	if is_crosscompile || tc-is-cross-compiler ; then
		CHOST=${CTARGET} strip-unsupported-flags
	fi

	# Store our CFLAGS because it's changed depending on which CTARGET
	# we are building when pulling glibc on a multilib profile
	CFLAGS_BASE=${CFLAGS_BASE-${CFLAGS}}
	CFLAGS=${CFLAGS_BASE}
	CXXFLAGS_BASE=${CXXFLAGS_BASE-${CXXFLAGS}}
	CXXFLAGS=${CXXFLAGS_BASE}
	ASFLAGS_BASE=${ASFLAGS_BASE-${ASFLAGS}}
	ASFLAGS=${ASFLAGS_BASE}

	strip-flags
	strip-unsupported-flags
	filter-flags -m32 -m64 -mabi=*
	filter-ldflags -Wl,-rpath=*

	filter-flags -frecord-gcc-switches

	unset CBUILD_OPT CTARGET_OPT

	setup_target_flags

	if [[ -n ${CTARGET_OPT} && ${CBUILD} == ${CHOST} ]] && ! is_crosscompile; then
		CBUILD_OPT=${CTARGET_OPT}
	fi

	# Lock glibc at -O2 -- linuxthreads needs it and we want to be
	# conservative here.  -fno-strict-aliasing is to work around #155906
	filter-flags -O?
	append-flags -O2 -fno-strict-aliasing

	append-cppflags -DPIC

}

want_nptl() {
	[[ -z ${LT_VER} ]] && return 0
	want_tls || return 1
	use nptl || return 1

	# Older versions of glibc had incomplete arch support for nptl.
	# But if you're building those now, you can handle USE=nptl yourself.
	return 0
}

want_linuxthreads() {
	[[ -z ${LT_VER} ]] && return 1
	use linuxthreads
}

want_tls() {
	# Archs that can use TLS (Thread Local Storage)
	case $(tc-arch) in
		x86)
			# requires i486 or better #106556
			[[ ${CTARGET} == i[4567]86* ]] && return 0
			return 1
		;;
	esac

	return 0
}

want__thread() {
	want_tls || return 1

	# For some reason --with-tls --with__thread is causing segfaults on sparc32.
	[[ ${PROFILE_ARCH} == "sparc" ]] && return 1

	[[ -n ${WANT__THREAD} ]] && return ${WANT__THREAD}

	# only test gcc -- can't test linking yet
	tc-has-tls -c ${CTARGET}
	WANT__THREAD=$?

	return ${WANT__THREAD}
}

setup_env() {
	unset LD_RUN_PATH
	unset LD_ASSUME_KERNEL

	setup_flags

	export ABI=${ABI:-${DEFAULT_ABI:-default}}

	if use headers-only ; then
		# Avoid mixing host's CC and target's CFLAGS_${ABI}:
		# At this bootstrap stage we have only binutils for
		# target but not compiler yet.
		einfo "Skip CC ABI injection. We can't use (cross-)compiler yet."
		return 0
	fi

	local VAR=CFLAGS_${ABI}
	# We need to export CFLAGS with abi information in them because glibc's
	# configure script checks CFLAGS for some targets (like mips).  Keep
	# around the original clean value to avoid appending multiple ABIs on
	# top of each other.
	: ${__GLIBC_CC:=$(tc-getCC ${CTARGET_OPT:-${CTARGET}})}
	export __GLIBC_CC CC="${__GLIBC_CC} ${!VAR}"
	einfo " $(printf '%15s' 'Manual CC:')   ${CC}"
}

foreach_abi() {
	setup_env

	local ret=0
	local abilist=""
	abilist=${DEFAULT_ABI}
	local -x ABI
	for ABI in ${abilist:-default} ; do
		setup_env
		einfo "Running $1 for ABI ${ABI}"
		$1
		: $(( ret |= $? ))
	done
	return ${ret}
}

just_headers() {
	is_crosscompile && use headers-only
}

glibc_banner() {
	local b="1g4 ${PVR}"
	[[ -n ${SNAP_VER} ]] && b+=" snapshot ${SNAP_VER}"
	[[ -n ${BRANCH_UPDATE} ]] && b+=" branch ${BRANCH_UPDATE}"
	[[ -n ${PATCH_VER} ]] && ! use vanilla && b+=" p${PATCH_VER}"
	echo "${b}"
}

# == phases ==

glibc_compile_test() {
	local ret save_cflags=${CFLAGS}
	CFLAGS+=" $1"
	shift

	pushd "${T}" >/dev/null

	rm -f glibc-test*
	printf '%b' "$*" > glibc-test.c

	_nonfatal emake -s glibc-test
	ret=$?

	popd >/dev/null

	CFLAGS=${save_cflags}
	return ${ret}
}

glibc_run_test() {
	local ret

	if [[ ${EMERGE_FROM} == "binary" ]] ; then
		# ignore build failures when installing a binary package #324685
		glibc_compile_test "" "$@" 2>/dev/null || return 0
	else
		if ! glibc_compile_test "" "$@" ; then
			ewarn "Simple build failed ... assuming this is desired #324685"
			return 0
		fi
	fi

	pushd "${T}" >/dev/null

	./glibc-test
	ret=$?
	rm -f glibc-test*

	popd >/dev/null

	return ${ret}
}

check_devpts() {
	# Make sure devpts is mounted correctly for use w/out setuid pt_chown.

	# If merely building the binary package, then there's nothing to verify.
	[[ ${MERGE_TYPE} == "buildonly" ]] && return

	# Only sanity check when installing the native glibc.
	[[ ${ROOT} != "/" ]] && return

	# Older versions always installed setuid, so no need to check.
	in_iuse suid || return

	# If they're opting in to the old suid code, then no need to check.
	use suid && return

	if awk '$3 == "devpts" && $4 ~ /[, ]gid=5[, ]/ { exit 1 }' /proc/mounts ; then
		eerror "In order to use glibc with USE=-suid, you must make sure that"
		eerror "you have devpts mounted at /dev/pts with the gid=5 option."
		eerror "Openrc should do this for you, so you should check /etc/fstab"
		eerror "and make sure you do not have any invalid settings there."
		# Do not die on older kernels as devpts did not export these settings #489520.
		if version_is_at_least 2.6.25 $(uname -r) ; then
			die "mount & fix your /dev/pts settings"
		fi
	fi
}

int_to_KV() {
	local version=$1 major minor micro
	major=$((version / 65536))
	minor=$(((version % 65536) / 256))
	micro=$((version % 256))
	echo ${major}.${minor}.${micro}
}

eend_KV() {
	[[ $(KV_to_int $1) -ge $(KV_to_int $2) ]]
	eend $?
}

get_kheader_version() {
	printf '#include <linux/version.h>\nLINUX_VERSION_CODE\n' | \
	$(tc-getCPP ${CTARGET}) -I "$(alt_build_headers)" - | \
	tail -n 1
}

check_nptl_support() {
	# don't care about the compiler here as we aren't using it
	just_headers && return

	local run_kv build_kv want_kv
	run_kv=$(int_to_KV $(get_KV))
	build_kv=$(int_to_KV $(get_kheader_version))
	want_kv=${NPTL_KERN_VER}

	ebegin "Checking gcc for __thread support"
	if ! eend $(want__thread ; echo $?) ; then
		echo
		eerror "Could not find a gcc that supports the __thread directive!"
		eerror "Please update your binutils/gcc and try again."
		die "No __thread support in gcc!"
	fi

	if ! is_crosscompile && ! tc-is-cross-compiler ; then
		# Building fails on an non-supporting kernel
		ebegin "Checking kernel version (${run_kv} >= ${want_kv})"
		if ! eend_KV ${run_kv} ${want_kv} ; then
			echo
			eerror "You need a kernel of at least ${want_kv} for NPTL support!"
			die "Kernel version too low!"
		fi
	fi

	ebegin "Checking stable-sources version (${build_kv} >= ${want_kv})"
	if ! eend_KV ${build_kv} ${want_kv} ; then
		echo
		eerror "You need stable-sources of at least ${want_kv} for NPTL support!"
		die "stable-sources version too low!"
	fi
}

unpack_pkg() {
	local a=${PN}
	[[ -n ${SNAP_VER} ]] && a="${a}-${RELEASE_VER}"
	[[ -n $1 ]] && a="${a}-$1"
	if [[ -n ${SNAP_VER} ]] ; then
		a="${a}-${SNAP_VER}"
	else
		if [[ -n $2 ]] ; then
			a="${a}-$2"
		else
			a="${a}-${RELEASE_VER}"
		fi
	fi
	if has ${a}.tar.xz ${A} ; then
		unpacker ${a}.tar.xz
	else
		unpack ${a}.tar.bz2
	fi
	[[ -n $1 ]] && { mv ${a} $1 || die ; }
}

src_strip() {
	# gdb is lame and requires some debugging information to remain in
	# libpthread, so we need to strip it by hand.  libthread_db makes no
	# sense stripped as it is only used when debugging.
	local pthread=$(has splitdebug ${FEATURES} && echo "libthread_db" || echo "lib{pthread,thread_db}")
	env \
		-uRESTRICT \
		CHOST=${CTARGET} \
		STRIP_MASK="/*/{,tls/}${pthread}*" \
		prepallstrip
	# if user has stripping enabled and does not have split debug turned on,
	# then leave the debugging sections in libpthread.
	if ! has nostrip ${FEATURES} && ! has splitdebug ${FEATURES} ; then
		${STRIP:-${CTARGET}-strip} --strip-debug "${ED}"/*/*/libpthread-*.so
	fi
}

glibc_sanity_check() {
	pushd "${ED}"/usr/$(get_libdir) >/dev/null

	local x striptest
	for x in cal date env free ls true uname uptime ; do
		x=$(type -p ${x})
		[[ -z ${x} || ${x} != ${EPREFIX}/* ]] && continue
		striptest=$(LC_ALL="C" file -L ${x} 2>/dev/null) || continue
		case ${striptest} in
		*"statically linked"*) continue;;
		*"ASCII text"*) continue;;
		esac
		# We need to clear the locale settings as the upgrade might want
		# incompatible locale data.  This test is not for verifying that.
		LC_ALL=C \
		./ld-*.so --library-path . ${x} > /dev/null \
			|| die "simple run test (${x}) failed"
	done

	popd >/dev/null
}

_TOOLCHAIN_GLIBC_ECLASS=1
fi
