# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="The GNU Compiler Collection"
HOMEPAGE="https://gcc.gnu.org/"

inherit flag-o-matic libtool toolchain-funcs prefix

case ${EAPI:-0} in
	0|1|2|3|4*) die "Need to upgrade to at least EAPI=5" ;;
	5|6|7*)   ;;
	*)       die "I don't speak EAPI ${EAPI}." ;;
esac
EXPORT_FUNCTIONS src_unpack src_prepare src_configure \
	src_compile src_test src_install pkg_postinst pkg_postrm

#---->> globals <<----

export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} = ${CHOST} ]] ; then
	if [[ ${CATEGORY} == cross-* ]] ; then
		export CTARGET=${CATEGORY#cross-}
	fi
fi
: ${TARGET_ABI:=${ABI}}
: ${TARGET_DEFAULT_ABI:=${DEFAULT_ABI}}

GCC_PV=${TOOLCHAIN_GCC_PV:-${PV}}
GCC_PVR=${GCC_PV}
[[ ${PR} != "r0" ]] && GCC_PVR=${GCC_PVR}-${PR}
GCC_RELEASE_VER=$(ver_cut 1-3 ${GCC_PV})
GCC_BRANCH_VER=$(ver_cut 1-2 ${GCC_PV})
GCCMAJOR=$(ver_cut 1 ${GCC_PV})
GCCMINOR=$(ver_cut 2 ${GCC_PV})
GCCMICRO=$(ver_cut 3 ${GCC_PV})
[[ ${BRANCH_UPDATE-notset} == "notset" ]] && \
	BRANCH_UPDATE=$(ver_cut 4 ${GCC_PV})

PREFIX="${EPREFIX}"/usr
BINPATH="${EPREFIX}"/usr/bin
LIBPATH="${EPREFIX}"/usr/lib
DATAPATH="${EPREFIX}"/usr/share

#---->> LICENSE+SLOT+IUSE logic <<----

LICENSE="GPL-3+ LGPL-3+ || ( GPL-3+ libgcc libstdc++ gcc-runtime-library-exception-3.1 ) FDL-1.3+"

IUSE="debug openmp fixed-point +isl sanitize cilk +vtv"

SLOT=0

BDEPEND="sys-devel/chrpath"

DEPEND="lib-sys/zlib
		lib-dev/mpc
		sys-devel/binutils
		isl? ( lib-dev/isl )
"

if [[ -n ${SNAPSHOT} ]] ; then
	SRC_URI="ftp://gcc.gnu.org/pub/gcc/snapshots/${SNAPSHOT}/gcc-${SNAPSHOT}.tar.xz"
else
	SRC_URI="mirror://gnu/gcc/gcc-${GCC_PV}/gcc-${GCC_RELEASE_VER}.tar.xz"
fi


####################
#---->> src_unpack <<----

toolchain_src_unpack() {
		gcc_quick_unpack
}

gcc_quick_unpack() {
	pushd "${WORKDIR}" > /dev/null

	if [[ -n ${SNAPSHOT} ]] ; then
			unpack gcc-${SNAPSHOT}.tar.xz
	elif [[ ${PV} != *9999* ]] ; then
			unpack gcc-${GCC_RELEASE_VER}.tar.xz
		# We want branch updates to be against a release tarball
		if [[ -n ${BRANCH_UPDATE} ]] ; then
			pushd "${S}" > /dev/null
			eapply "${DISTDIR}"/gcc-${GCC_RELEASE_VER}-branch-update-${BRANCH_UPDATE}.patch.bz2
			popd > /dev/null
		fi
	fi

	popd > /dev/null
}

####################
### src_prepare
S=${WORKDIR}/${PN}-${SNAPSHOT}
toolchain_src_prepare() {
	cd "${S}"

	default

	if [[ -n ${SNAPSHOT} || -n ${PRERELEASE} ]] ; then
		# BASE-VER must be a three-digit version number
		# followed by an optional -pre string
		#   eg. 4.5.1, 4.6.2-pre20120213, 4.7.0-pre9999
		# If BASE-VER differs from ${PV/_/-} then libraries get installed in
		# the wrong directory.
		echo ${PV/_/-} > "${S}"/gcc/BASE-VER
	fi

	# Fixup libtool to correctly generate .la files with portage
	elibtoolize --portage --shallow --no-uclibc

	# update configure files
	local f
	einfo "Fixing misc issues in configure files"
	for f in $(grep -l 'autoconf version 2.13' $(find "${S}" -name configure)) ; do
		ebegin "  Updating ${f/${S}\/} [LANG]"
		patch "${f}" "${FILESDIR}"/gcc-configure-LANG.patch >& "${T}"/configure-patch.log \
			|| eerror "Please file a bug about this"
		eend $?
	done
	sed -i 's|A-Za-z0-9|[:alnum:]|g' "${S}"/gcc/*.awk #215828

	if [[ -x contrib/gcc_update ]] ; then
		einfo "Touching generated files"
		./contrib/gcc_update --touch | \
			while read f ; do
				einfo "  ${f%%...}"
			done
	fi
}

#---->> src_configure <<----

toolchain_src_configure() {
	downgrade_arch_flags
	gcc_do_filter_flags

	einfo "CFLAGS=\"${CFLAGS}\""
	einfo "CXXFLAGS=\"${CXXFLAGS}\""
	einfo "LDFLAGS=\"${LDFLAGS}\""

	# Force internal zip based jar script to avoid random
	# issues with 3rd party jar implementations.  #384291
	export JAR=no

	local confgcc=( --host=${CHOST} )

	[[ -n ${CBUILD} ]] && confgcc+=( --build=${CBUILD} )

	confgcc+=(
		--prefix="${EPREFIX}"/usr
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--includedir="${EPREFIX}"/usr/include
		--datadir="${EPREFIX}"/usr/share
		--mandir="${EPREFIX}"/usr/share/man
		--infodir="${EPREFIX}"/usr/share/info
	)


	confgcc+=( --with-python-dir=${DATAPATH/$PREFIX/}/python )

	### general options

	confgcc+=(
		--disable-obsolete
		--disable-werror
		--with-system-zlib
		--disable-libmudflap
		--enable-default-ssp
		--enable-default-pie
		--enable-lto
		--enable-nls
		--enable-libstdcxx-time
		--disable-multilib
		--disable-rpath
		--enable-threads=posix
		--enable-__cxa_atexit
		--enable-clocale=gnu
		--enable-gnu-unique-object
		--enable-checking=release
		--with-linker-hash-style=gnu
		--enable-gnu-indirect-function
		--enable-linker-build-id
		--disable-libmpx
		--disable-libgcj
		--enable-languages=c,c++,lto
		--enable-bootstrap
		--with-build-config="bootstrap-lto-lean"
		$(use_with isl)
		$(use_enable openmp libgomp)
		$(use_enable vtv vtable-verify)
		$(use_enable vtv libvtv)
		$(use_enable sanitize libsanitizer)
)

	if use debug ; then
		# The "release" keyword is new to 4.0. #551636
		local off=$(echo release)
		confgcc+=( --enable-checking="${GCC_CHECKS_LIST:-$(usex debug yes ${off})}" )
	fi

	if tc-is-static-only ; then
		confgcc+=( --disable-shared )
	else
		confgcc+=( --enable-shared )
	fi

	### arch options

	use fixed-point && confgcc+=( $(use_enable fixed-point) )

	case $(tc-is-softfloat) in
	yes)    confgcc+=( --with-float=soft ) ;;
	softfp) confgcc+=( --with-float=softfp ) ;;
	*)
		# If they've explicitly opt-ed in, do hardfloat,
		# otherwise let the gcc default kick in.
		case ${CTARGET//_/-} in
		*-hardfloat-*|*eabihf) confgcc+=( --with-float=hard ) ;;
		esac
	esac

	### library options

	if use cilk ; then
		confgcc+=( $(use_enable cilk libcilkrts) )
	fi

	# Disable gcc info regeneration -- it ships with generated info pages
	# already.  Our custom version/urls/etc... trigger it.  #464008
	export gcc_cv_prog_makeinfo_modern=no

	confgcc+=( "$@" ${EXTRA_ECONF} )

	# Nothing wrong with a good dose of verbosity
	echo
	einfo "PREFIX:          ${PREFIX}"
	einfo "BINPATH:         ${BINPATH}"
	einfo "LIBPATH:         ${LIBPATH}"
	einfo "DATAPATH:        ${DATAPATH}"
	echo
	einfo "Languages:       ${GCC_LANG}"
	echo
	einfo "Configuring GCC with: ${confgcc[@]//--/\n\t--}"
	echo

	# Build in a separate build tree
	mkdir -p "${WORKDIR}"/build
	pushd "${WORKDIR}"/build > /dev/null

	# and now to do the actual configuration
	addwrite /dev/zero
	echo "${S}"/configure "${confgcc[@]}"
	# Older gcc versions did not detect bash and re-exec itself, so force the
	# use of bash.  Newer ones will auto-detect, but this is not harmeful.
	CONFIG_SHELL="${EPREFIX}/bin/bash" \
	bash "${S}"/configure "${confgcc[@]}" || die "failed to run configure"

	# return to whatever directory we were in before
	popd > /dev/null
}

# Replace -m flags unsupported by the version being built with the best
# available equivalent
downgrade_arch_flags() {
	local arch bver i isa myarch mytune rep ver

	bver=${1:-${GCC_BRANCH_VER}}
	[[ $(gcc-version) < ${bver} ]] && return 0
	[[ $(tc-arch) != amd64 && $(tc-arch) != x86 ]] && return 0

	myarch=$(get-flag march)
	mytune=$(get-flag mtune)

	# If -march=native isn't supported we have to tease out the actual arch
	if [[ ${myarch} == native || ${mytune} == native ]] ; then
		if [[ ${bver} < 4.2 ]] ; then
			arch=$($(tc-getCC) -march=native -v -E -P - </dev/null 2>&1 \
				| sed -rn "/cc1.*-march/s:.*-march=([^ ']*).*:\1:p")
			replace-cpu-flags native ${arch}
		fi
	fi

	# Handle special -mtune flags
	[[ ${mytune} == intel && ${bver} < 4.9 ]] && replace-cpu-flags intel generic
	[[ ${mytune} == generic && ${bver} < 4.2 ]] && filter-flags '-mtune=*'
	[[ ${mytune} == x86-64 ]] && filter-flags '-mtune=*'
	[[ ${bver} < 3.4 ]] && filter-flags '-mtune=*'

	# "added" "arch" "replacement"
	local archlist=(
		4.9 bdver4 bdver3
		4.9 bonnell atom
		4.9 broadwell core-avx2
		4.9 haswell core-avx2
		4.9 ivybridge core-avx-i
		4.9 nehalem corei7
		4.9 sandybridge corei7-avx
		4.9 silvermont corei7
		4.9 westmere corei7
		4.8 bdver3 bdver2
		4.8 btver2 btver1
		4.7 bdver2 bdver1
		4.7 core-avx2 core-avx-i
		4.6 bdver1 amdfam10
		4.6 btver1 amdfam10
		4.6 core-avx-i core2
		4.6 corei7 core2
		4.6 corei7-avx core2
		4.5 atom core2
		4.3 amdfam10 k8
		4.3 athlon64-sse3 k8
		4.3 barcelona k8
		4.3 core2 nocona
		4.3 geode k6-2 # gcc.gnu.org/PR41989#c22
		4.3 k8-sse3 k8
		4.3 opteron-sse3 k8
		3.4 athlon-fx x86-64
		3.4 athlon64 x86-64
		3.4 c3-2 c3
		3.4 k8 x86-64
		3.4 opteron x86-64
		3.4 pentium-m pentium3
		3.4 pentium3m pentium3
		3.4 pentium4m pentium4
	)

	for ((i = 0; i < ${#archlist[@]}; i += 3)) ; do
		myarch=$(get-flag march)
		mytune=$(get-flag mtune)

		ver=${archlist[i]}
		arch=${archlist[i + 1]}
		rep=${archlist[i + 2]}

		[[ ${myarch} != ${arch} && ${mytune} != ${arch} ]] && continue

		if [[ ${ver} > ${bver} ]] ; then
			einfo "Replacing ${myarch} (added in gcc ${ver}) with ${rep}..."
			[[ ${myarch} == ${arch} ]] && replace-cpu-flags ${myarch} ${rep}
			[[ ${mytune} == ${arch} ]] && replace-cpu-flags ${mytune} ${rep}
			continue
		else
			break
		fi
	done

	# we only check -mno* here since -m* get removed by strip-flags later on
	local isalist=(
		4.9 -mno-sha
		4.9 -mno-avx512pf
		4.9 -mno-avx512f
		4.9 -mno-avx512er
		4.9 -mno-avx512cd
		4.8 -mno-xsaveopt
		4.8 -mno-xsave
		4.8 -mno-rtm
		4.8 -mno-fxsr
		4.7 -mno-lzcnt
		4.7 -mno-bmi2
		4.7 -mno-avx2
		4.6 -mno-tbm
		4.6 -mno-rdrnd
		4.6 -mno-fsgsbase
		4.6 -mno-f16c
		4.6 -mno-bmi
		4.5 -mno-xop
		4.5 -mno-movbe
		4.5 -mno-lwp
		4.5 -mno-fma4
		4.4 -mno-pclmul
		4.4 -mno-fma
		4.4 -mno-avx
		4.4 -mno-aes
		4.3 -mno-ssse3
		4.3 -mno-sse4a
		4.3 -mno-sse4
		4.3 -mno-sse4.2
		4.3 -mno-sse4.1
		4.3 -mno-popcnt
		4.3 -mno-abm
	)

	for ((i = 0; i < ${#isalist[@]}; i += 2)) ; do
		ver=${isalist[i]}
		isa=${isalist[i + 1]}
		[[ ${ver} > ${bver} ]] && filter-flags ${isa} ${isa/-m/-mno-}
	done
}

gcc_do_filter_flags() {
	strip-flags
	replace-flags -O? -O2

	# dont want to funk ourselves
	filter-flags '-mabi*' -m31 -m32 -m64

	append-flags -Wa,--noexecstack

	filter-flags -frecord-gcc-switches # 490738
	filter-flags -mno-rtm -mno-htm # 506202

	strip-unsupported-flags
}

gcc-abi-map() {
	# Convert the ABI name we use in Gentoo to what gcc uses
	local map=()
	case ${CTARGET} in
	mips*)   map=("o32 32" "n32 n32" "n64 64") ;;
	x86_64*) map=("amd64 m64" "x86 m32" "x32 mx32") ;;
	esac

	local m
	for m in "${map[@]}" ; do
		l=( ${m} )
		[[ $1 == ${l[0]} ]] && echo ${l[1]} && break
	done
}

#----> src_compile <----

toolchain_src_compile() {
	touch "${S}"/gcc/c-gperf.h

	# Do not make manpages if we do not have perl ...
	[[ ! -x /usr/bin/perl ]] \
		&& find "${WORKDIR}"/build -name '*.[17]' -exec touch {} +

	gcc_do_make ${GCC_MAKE_TARGET}
}

gcc_do_make() {

	[[ -n ${1} ]] && GCC_MAKE_TARGET=${1}

	GCC_MAKE_TARGET=${GCC_MAKE_TARGET-profiledbootstrap}

	STAGE1_CFLAGS=${STAGE1_CFLAGS-"${CFLAGS}"}

	BOOT_CFLAGS=${BOOT_CFLAGS-"${CFLAGS}"}

	einfo "Compiling ${PN} (${GCC_MAKE_TARGET})..."

	pushd "${WORKDIR}"/build >/dev/null

	emake \
		LDFLAGS="${LDFLAGS}" \
		STAGE1_CFLAGS="${STAGE1_CFLAGS}" \
		LIBPATH="${LIBPATH}" \
		BOOT_CFLAGS="${CFLAGS}" \
		${GCC_MAKE_TARGET} \
		|| die "emake failed with ${GCC_MAKE_TARGET}"

	popd >/dev/null
}

#---->> src_test <<----

toolchain_src_test() {
	if use test ; then
		cd "${WORKDIR}"/build
		emake -k check
	fi
}

#---->> src_install <<----

toolchain_src_install() {
	cd "${WORKDIR}"/build

	# Do allow symlinks in private gcc include dir as this can break the build
	find gcc/include*/ -type l -delete

	# Copy over the info pages.  We disabled their generation earlier, but the
	# build system only expects to install out of the build dir, not the source.  #464008
	mkdir -p gcc/doc
	local x=
	for x in "${S}"/gcc/doc/*.info* ; do
		if [[ -f ${x} ]] ; then
			cp "${x}" gcc/doc/ || die
		fi
	done

	# We remove the generated fixincludes, as they can cause things to break
	# (ncurses, openssl, etc).  We do not prevent them from being built, as
	# in the following commit which we revert:
	# https://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/eclass/toolchain.eclass?r1=1.647&r2=1.648
	# This is because bsd userland needs fixedincludes to build gcc, while
	# linux does not.  Both can dispose of them afterwards.
	while read x ; do
		grep -q 'It has been auto-edited by fixincludes from' "${x}" \
			&& rm -f "${x}"
	done < <(find gcc/include*/ -name '*.h')

	# Do the 'make install' from the build directory
	S="${WORKDIR}"/build emake -j1 DESTDIR="${D}" install || die

	# Punt some tools which are really only useful while building gcc
	find "${D}" -name install-tools -prune -type d -exec rm -rf "{}" \;
	# This one comes with binutils
	find "${D}" -name libiberty.a -delete

	# Basic sanity check
	local EXEEXT
	eval $(grep ^EXEEXT= "${WORKDIR}"/build/gcc/config.log)
	[[ -r ${D}/${BINPATH}/gcc${EXEEXT} ]] || die "gcc not found in ${D}"

	dodir /etc/env.d/gcc

	# prune empty dirs left behind
	find "${D}" -depth -type d -delete 2>/dev/null

	# Rather install the script, else portage with changing $FILESDIR
	# between binary and source package borks things ....
		insinto "${DATAPATH#${EPREFIX}}"
		newins "$(prefixify_ro "${FILESDIR}"/awk/fixlafiles.awk-no_gcc_la)" fixlafiles.awk || die
		exeinto "${DATAPATH#${EPREFIX}}"
		doexe "$(prefixify_ro "${FILESDIR}"/fix_libtool_files.sh)" || die
		doexe "${FILESDIR}"/c{89,99} || die

	# libstdc++.la: Delete as it doesn't add anything useful: g++ itself
	# handles linkage correctly in the dynamic & static case.  It also just
	# causes us pain: any C++ progs/libs linking with libtool will gain a
	# reference to the full libstdc++.la file which is gcc version specific.
	# libstdc++fs.la: It doesn't link against anything useful.
	# libsupc++.la: This has no dependencies.
	# libcc1.la: There is no static library, only dynamic.
	# libcc1plugin.la: Same as above, and it's loaded via dlopen.
	# libgomp.la: gcc itself handles linkage (libgomp.spec).
	# libgomp-plugin-*.la: Same as above, and it's an internal plugin only
	# loaded via dlopen.
	# libgfortran.la: gfortran itself handles linkage correctly in the
	# dynamic & static case (libgfortran.spec). #573302
	# libgfortranbegin.la: Same as above, and it's an internal lib.
	# libitm.la: gcc itself handles linkage correctly (libitm.spec).
	# libvtv.la: gcc itself handles linkage correctly.
	# lib*san.la: Sanitizer linkage is handled internally by gcc, and they
	# do not support static linking. #487550 #546700
	find "${D}/${LIBPATH}" \
		'(' \
			-name libstdc++.la -o \
			-name libstdc++fs.la -o \
			-name libsupc++.la -o \
			-name libcc1.la -o \
			-name libcc1plugin.la -o \
			-name 'libgomp.la' -o \
			-name 'libgomp-plugin-*.la' -o \
			-name libgfortran.la -o \
			-name libgfortranbegin.la -o \
			-name libitm.la -o \
			-name libvtv.la -o \
			-name 'lib*san.la' \
		')' -type f -delete

	# Use gid of 0 because some stupid ports don't have
	# the group 'root' set to gid 0.  Send to /dev/null
	# for people who are testing as non-root.
	chown -R root:0 "${D}/${LIBPATH}" 2>/dev/null

	# Move pretty-printers to gdb datadir to shut ldconfig up
	local py gdbdir=/usr/share/gdb/auto-load${LIBPATH/\/lib\//\/lib64\/}
	pushd "${D}/${LIBPATH}" >/dev/null
	for py in $(find . -name '*-gdb.py') ; do
		local multidir=${py%/*}
		insinto "${gdbdir}/${multidir}"
		sed -i "/^libdir =/s:=.*:= '${LIBPATH}/${multidir}':" "${py}" || die #348128
		doins "${py}" || die
		rm "${py}" || die
	done
	popd >/dev/null

	chrpath -d "${ED}"/usr/lib64/libstdc++.so*
	cleanup_install
}


# make sure the libtool archives have libdir set to where they actually
# -are-, and not where they -used- to be.  also, any dependencies we have
# on our own .la files need to be updated.
fix_libtool_libdir_paths() {
	local libpath="$1"

	pushd "${D}" >/dev/null

	pushd "./${libpath}" >/dev/null
	local dir="${PWD#${D%/}}"
	local allarchives=$(echo *.la)
	allarchives="\(${allarchives// /\\|}\)"
	popd >/dev/null

	# The libdir might not have any .la files. #548782
	find "./${dir}" -maxdepth 1 -name '*.la' \
		-exec sed -i -e "/^libdir=/s:=.*:='${dir}':" {} + || die
	# Would be nice to combine these, but -maxdepth can not be specified
	# on sub-expressions.
	find "./${PREFIX}"/lib* -maxdepth 3 -name '*.la' \
		-exec sed -i -e "/^dependency_libs=/s:/[^ ]*/${allarchives}:${libpath}/\1:g" {} + || die
	find "./${dir}/" -maxdepth 1 -name '*.la' \
		-exec sed -i -e "/^dependency_libs=/s:/[^ ]*/${allarchives}:${libpath}/\1:g" {} + || die

	popd >/dev/null
}

#---->> pkg_post* <<----

toolchain_pkg_postinst() {
	# Clean up old paths
	rm -f "${EROOT}"/*/rcscripts/awk/fixlafiles.awk "${EROOT}"/usr/sbin/fix_libtool_files.sh
	rmdir "${EROOT}"*/rcscripts{/awk,} 2>/dev/null

	mkdir -p "${EROOT}"/usr/{share/gcc-data,sbin,bin}
	# DATAPATH has EPREFIX already, use ROOT with it
	cp "${ROOT}/${DATAPATH}"/fixlafiles.awk "${EROOT}"/usr/share/gcc-data/ || die
	cp "${ROOT}/${DATAPATH}"/fix_libtool_files.sh "${EROOT}"/usr/sbin/ || die

	# Since these aren't critical files and portage sucks with
	# handling of binpkgs, don't require these to be found
	cp "${ROOT}/${DATAPATH}"/c{89,99} "${EROOT}"/usr/bin/ 2>/dev/null
}

toolchain_pkg_postrm() {
	if [[ ${ROOT} == / && -f ${EPREFIX}/usr/share/eselect/modules/compiler-shadow.eselect ]] ; then
		eselect compiler-shadow clean all
	fi

	# to make our lives easier (and saner), we do the fix_libtool stuff here.
	# rather than checking SLOT's and trying in upgrade paths, we just see if
	# the common libstdc++.la exists in the ${LIBPATH} of the gcc that we are
	# unmerging.  if it does, that means this was a simple re-emerge.

	# ROOT isnt handled by the script
	[[ ${ROOT} != "/" ]] && return 0

	if [[ ! -e ${LIBPATH}/libstdc++.so ]] ; then
		einfo "Running 'fix_libtool_files.sh ${GCC_RELEASE_VER}'"
		fix_libtool_files.sh ${GCC_RELEASE_VER}
		if [[ -n ${BRANCH_UPDATE} ]] ; then
			einfo "Running 'fix_libtool_files.sh ${GCC_RELEASE_VER}-${BRANCH_UPDATE}'"
			fix_libtool_files.sh ${GCC_RELEASE_VER}-${BRANCH_UPDATE}
		fi
	fi

	return 0
}

#---->> support and misc functions <<----

# This is to make sure we don't accidentally try to enable support for a
# language that doesnt exist. GCC 3.4 supports f77, while 4.0 supports f95, etc.
#
# Also add a hook so special ebuilds (kgcc64) can control which languages
# exactly get enabled
gcc-lang-supported() {
	grep ^language=\"${1}\" "${S}"/gcc/*/config-lang.in > /dev/null || return 1
	[[ -z ${TOOLCHAIN_ALLOWED_LANGS} ]] && return 0
	has $1 ${TOOLCHAIN_ALLOWED_LANGS}
}

# Grab a variable from the build system (taken from linux-info.eclass)
get_make_var() {
	local var=$1 makefile=${2:-${WORKDIR}/build/Makefile}
	echo -e "e:\\n\\t@echo \$(${var})\\ninclude ${makefile}" | \
		r=${makefile%/*} emake --no-print-directory -s -f - 2>/dev/null
}

XGCC() { get_make_var GCC_FOR_TARGET ; }


