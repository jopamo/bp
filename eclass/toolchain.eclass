# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="The GNU Compiler Collection"
HOMEPAGE="https://gcc.gnu.org/"
RESTRICT="strip" # cross-compilers need controlled stripping

inherit eutils fixheadtails flag-o-matic gnuconfig libtool toolchain-funcs versionator prefix

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

is_crosscompile() {
	[[ ${CHOST} != ${CTARGET} ]]
}

# General purpose version check.  Without a second arg matches up to minor version (x.x.x)
tc_version_is_at_least() {
	version_is_at_least "$1" "${2:-${GCC_RELEASE_VER}}"
}

# General purpose version range check
# Note that it matches up to but NOT including the second version
tc_version_is_between() {
	tc_version_is_at_least "${1}" && ! tc_version_is_at_least "${2}"
}

GCC_PV=${TOOLCHAIN_GCC_PV:-${PV}}
GCC_PVR=${GCC_PV}
[[ ${PR} != "r0" ]] && GCC_PVR=${GCC_PVR}-${PR}
GCC_RELEASE_VER=$(get_version_component_range 1-3 ${GCC_PV})
GCC_BRANCH_VER=$(get_version_component_range 1-2 ${GCC_PV})
GCCMAJOR=$(get_version_component_range 1 ${GCC_PV})
GCCMINOR=$(get_version_component_range 2 ${GCC_PV})
GCCMICRO=$(get_version_component_range 3 ${GCC_PV})
[[ ${BRANCH_UPDATE-notset} == "notset" ]] && \
	BRANCH_UPDATE=$(get_version_component_range 4 ${GCC_PV})

# According to gcc/c-cppbuiltin.c, GCC_CONFIG_VER MUST match this regex.
# ([^0-9]*-)?[0-9]+[.][0-9]+([.][0-9]+)?([- ].*)?
GCC_CONFIG_VER=${GCC_CONFIG_VER:-$(replace_version_separator 3 '-' ${GCC_PV})}

PREFIX=${TOOLCHAIN_PREFIX:-${EPREFIX}/usr}

if tc_version_is_at_least 3.4.0 ; then
	LIBPATH=${TOOLCHAIN_LIBPATH:-${PREFIX}/lib/gcc/${CTARGET}/${GCC_CONFIG_VER}}
else
	LIBPATH=${TOOLCHAIN_LIBPATH:-${PREFIX}/lib/gcc-lib/${CTARGET}/${GCC_CONFIG_VER}}
fi
INCLUDEPATH=${TOOLCHAIN_INCLUDEPATH:-${LIBPATH}/include}

if is_crosscompile ; then
	BINPATH=${TOOLCHAIN_BINPATH:-${PREFIX}/${CHOST}/${CTARGET}/gcc-bin/${GCC_CONFIG_VER}}
	HOSTLIBPATH=${PREFIX}/${CHOST}/${CTARGET}/lib/${GCC_CONFIG_VER}
else
	BINPATH=${TOOLCHAIN_BINPATH:-${PREFIX}/${CTARGET}/gcc-bin/${GCC_CONFIG_VER}}
fi

DATAPATH=${TOOLCHAIN_DATAPATH:-${PREFIX}/share/gcc-data/${CTARGET}/${GCC_CONFIG_VER}}

# Dont install in /usr/include/g++-v3/, but in gcc internal directory.
# We will handle /usr/include/g++-v3/ with gcc-config ...
STDCXX_INCDIR=${TOOLCHAIN_STDCXX_INCDIR:-${LIBPATH}/include/g++-v${GCC_BRANCH_VER/\.*/}}

#---->> LICENSE+SLOT+IUSE logic <<----

if tc_version_is_at_least 4.6 ; then
	LICENSE="GPL-3+ LGPL-3+ || ( GPL-3+ libgcc libstdc++ gcc-runtime-library-exception-3.1 ) FDL-1.3+"
fi

IUSE="regression-test vanilla"
IUSE_DEF=( nptl )

if [[ ${PN} != "kgcc64" && ${PN} != gcc-* ]] ; then
	IUSE+=" debug"
	IUSE_DEF+=( cxx fortran )
	tc_version_is_at_least 3 && IUSE+=" doc gcj awt hardened objc"
	tc_version_is_at_least 3.3 && IUSE+=" pgo"
	tc_version_is_at_least 4.0 && IUSE+=" objc-gc"
	tc_version_is_at_least 4.1 && IUSE+=" objc++"
	tc_version_is_at_least 4.2 && IUSE_DEF+=( openmp )
	tc_version_is_at_least 4.3 && IUSE+=" fixed-point"
	tc_version_is_at_least 4.7 && IUSE+=" go"
	tc_version_is_at_least 4.8 && IUSE+=" graphite sanitize"
	tc_version_is_at_least 4.9 && IUSE+=" cilk +vtv"
	tc_version_is_at_least 5.0 && IUSE+=" jit mpx"
fi

IUSE+=" ${IUSE_DEF[*]/#/+}"

SLOT="${GCC_CONFIG_VER}"

RDEPEND="lib-sys/zlib
		graphite? ( >=lib-dev/isl-0.14 )
		fortran? ( >=lib-dev/gmp-4.3.2:0=
					>=lib-dev/mpfr-2.4.2:0= )
		>=lib-dev/mpc-0.8.1:0=
		objc-gc? ( >=lib-dev/boehm-gc-7.4.2 )
"

DEPEND="${RDEPEND}
	>=sys-devel/bison-1.875
	sys-devel/chrpath
	>=sys-devel/flex-2.5.4
	regression-test? (
		>=dev-util/dejagnu-1.4.4
		>=sys-devel/autogen-5.5.4
	)
	gcj? ( awt? ( x11-libs/libXt x11-libs/libX11 x11-libs/libXtst x11/xorgproto x11-libs/pango =x11-libs/gtk+-2* dev-util/pkgconfig ) app-compression/zip app-compression/unzip >=lib-media/libart_lgpl-2.1 )"

PDEPEND=">=sys-devel/gcc-config-1.7"

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
		if tc_version_is_between 5.5 6 || tc_version_is_between 6.4 7 || tc_version_is_at_least 7.2 ; then
			unpack gcc-${SNAPSHOT}.tar.xz
		else
			unpack gcc-${SNAPSHOT}.tar.bz2
		fi
	elif [[ ${PV} != *9999* ]] ; then
		if tc_version_is_between 5.5 6 || tc_version_is_between 6.4 7 || tc_version_is_at_least 7.2 ; then
			unpack gcc-${GCC_RELEASE_VER}.tar.xz
		else
			unpack gcc-${GCC_RELEASE_VER}.tar.bz2
		fi
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

	if tc_version_is_at_least 4.1 ; then
		if [[ -n ${SNAPSHOT} || -n ${PRERELEASE} ]] ; then
			# BASE-VER must be a three-digit version number
			# followed by an optional -pre string
			#   eg. 4.5.1, 4.6.2-pre20120213, 4.7.0-pre9999
			# If BASE-VER differs from ${PV/_/-} then libraries get installed in
			# the wrong directory.
			echo ${PV/_/-} > "${S}"/gcc/BASE-VER
		fi
	fi

	# >= gcc-4.3 doesn't bundle ecj.jar, so copy it
	if tc_version_is_at_least 4.3 && use_if_iuse gcj ; then
		if tc_version_is_at_least 4.5 ; then
			einfo "Copying ecj-4.5.jar"
			cp -pPR "${DISTDIR}/ecj-4.5.jar" "${S}/ecj.jar" || die
		else
			einfo "Copying ecj-4.3.jar"
			cp -pPR "${DISTDIR}/ecj-4.3.jar" "${S}/ecj.jar" || die
		fi
	fi

	# Fixup libtool to correctly generate .la files with portage
	elibtoolize --portage --shallow --no-uclibc

	gnuconfig_update

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

do_gcc_rename_java_bins() {
	# bug #139918 - conflict between gcc and java-config-2 for ownership of
	# /usr/bin/rmi{c,registry}.	 Done with mv & sed rather than a patch
	# because patches would be large (thanks to the rename of man files),
	# and it's clear from the sed invocations that all that changes is the
	# rmi{c,registry} names to grmi{c,registry} names.
	# Kevin F. Quinn 2006-07-12
	einfo "Renaming jdk executables rmic and rmiregistry to grmic and grmiregistry."
	# 1) Move the man files if present (missing prior to gcc-3.4)
	for manfile in rmic rmiregistry ; do
		[[ -f ${S}/gcc/doc/${manfile}.1 ]] || continue
		mv "${S}"/gcc/doc/${manfile}.1 "${S}"/gcc/doc/g${manfile}.1
	done
	# 2) Fixup references in the docs if present (mission prior to gcc-3.4)
	for jfile in gcc/doc/gcj.info gcc/doc/grmic.1 gcc/doc/grmiregistry.1 gcc/java/gcj.texi ; do
		[[ -f ${S}/${jfile} ]] || continue
		sed -i -e 's:rmiregistry:grmiregistry:g' "${S}"/${jfile} ||
			die "Failed to fixup file ${jfile} for rename to grmiregistry"
		sed -i -e 's:rmic:grmic:g' "${S}"/${jfile} ||
			die "Failed to fixup file ${jfile} for rename to grmic"
	done
	# 3) Fixup Makefiles to build the changed executable names
	#	 These are present in all 3.x versions, and are the important bit
	#	 to get gcc to build with the new names.
	for jfile in libjava/Makefile.am libjava/Makefile.in gcc/java/Make-lang.in ; do
		sed -i -e 's:rmiregistry:grmiregistry:g' "${S}"/${jfile} ||
			die "Failed to fixup file ${jfile} for rename to grmiregistry"
		# Careful with rmic on these files; it's also the name of a directory
		# which should be left unchanged.  Replace occurrences of 'rmic$',
		# 'rmic_' and 'rmic '.
		sed -i -e 's:rmic\([$_ ]\):grmic\1:g' "${S}"/${jfile} ||
			die "Failed to fixup file ${jfile} for rename to grmic"
	done
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

	if is_crosscompile || tc-is-cross-compiler ; then
		# Straight from the GCC install doc:
		# "GCC has code to correctly determine the correct value for target
		# for nearly all native systems. Therefore, we highly recommend you
		# not provide a configure target when configuring a native compiler."
		confgcc+=( --target=${CTARGET} )
	fi
	[[ -n ${CBUILD} ]] && confgcc+=( --build=${CBUILD} )

	confgcc+=(
		--prefix="${PREFIX}"
		--bindir="${BINPATH}"
		--includedir="${INCLUDEPATH}"
		--datadir="${DATAPATH}"
		--mandir="${DATAPATH}/man"
		--infodir="${DATAPATH}/info"
		--with-gxx-include-dir="${STDCXX_INCDIR}"
	)

	# Stick the python scripts in their own slotted directory (bug #279252)
	#
	#  --with-python-dir=DIR
	#  Specifies where to install the Python modules used for aot-compile. DIR
	#  should not include the prefix used in installation. For example, if the
	#  Python modules are to be installed in /usr/lib/python2.5/site-packages,
	#  then --with-python-dir=/lib/python2.5/site-packages should be passed.
	#
	# This should translate into "/share/gcc-data/${CTARGET}/${GCC_CONFIG_VER}/python"
	if tc_version_is_at_least 4.4 ; then
		confgcc+=( --with-python-dir=${DATAPATH/$PREFIX/}/python )
	fi

	### language options

	local GCC_LANG="c"
	is_cxx && GCC_LANG+=",c++"
	is_d   && GCC_LANG+=",d"
	is_gcj && GCC_LANG+=",java"
	is_go  && GCC_LANG+=",go"
	is_jit && GCC_LANG+=",jit"
	if is_objc || is_objcxx ; then
		GCC_LANG+=",objc"
		if tc_version_is_at_least 4 ; then
			use objc-gc && confgcc+=( --enable-objc-gc )
		fi
		is_objcxx && GCC_LANG+=",obj-c++"
	fi

	# fortran support just got sillier! the lang value can be f77 for
	# fortran77, f95 for fortran95, or just plain old fortran for the
	# currently supported standard depending on gcc version.
	is_fortran && GCC_LANG+=",fortran"
	is_f77 && GCC_LANG+=",f77"
	is_f95 && GCC_LANG+=",f95"

	# We do NOT want 'ADA support' in here!
	# is_ada && GCC_LANG+=",ada"

	confgcc+=( --enable-languages=${GCC_LANG} )

	### general options

	confgcc+=(
		--disable-obsolete
		--enable-secureplt
		--disable-werror
		--with-system-zlib
		--disable-libmudflap
		--enable-default-ssp
		--enable-default-pie
		--enable-lto
		--enable-nls
		--enable-libstdcxx-time
		--enable-gold
)

	# Use the default ("release") checking because upstream usually neglects
	# to test "disabled" so it has a history of breaking. #317217
	if tc_version_is_at_least 3.4 && use debug ; then
		# The "release" keyword is new to 4.0. #551636
		local off=$(tc_version_is_at_least 4.0 && echo release || echo no)
		confgcc+=( --enable-checking="${GCC_CHECKS_LIST:-$(usex debug yes ${off})}" )
	fi

	### Cross-compiler options
	if is_crosscompile ; then
		# Enable build warnings by default with cross-compilers when system
		# paths are included (e.g. via -I flags).
		confgcc+=( --enable-poison-system-directories )

		# When building a stage1 cross-compiler (just C compiler), we have to
		# disable a bunch of features or gcc goes boom
		local needed_libc=""
		case ${CTARGET} in
		*-linux)		 needed_libc=no-fucking-clue;;
		*-dietlibc)		 needed_libc=dietlibc;;
		*-elf|*-eabi)	 needed_libc=newlib;;
		*-freebsd*)		 needed_libc=freebsd-lib;;
		*-gnu*)			 needed_libc=glibc;;
		*-klibc)		 needed_libc=klibc;;
		*-musl*)		 needed_libc=musl;;
		*-uclibc*)
			if ! echo '#include <features.h>' | \
			   $(tc-getCPP ${CTARGET}) -E -dD - 2>/dev/null | \
			   grep -q __HAVE_SHARED__
			then #291870
				confgcc+=( --disable-shared )
			fi
			needed_libc=uclibc
			;;
		*-cygwin)		 needed_libc=cygwin;;
		x86_64-*-mingw*|\
		*-w64-mingw*)	 needed_libc=mingw64-runtime;;
		mingw*|*-mingw*) needed_libc=mingw-runtime;;
		avr)			 confgcc+=( --enable-shared --disable-threads );;
		esac
		if [[ -n ${needed_libc} ]] ; then
			local confgcc_no_libc=( --disable-shared )
			tc_version_is_at_least 4.8 && confgcc_no_libc+=( --disable-libatomic )
			if ! has_version ${CATEGORY}/${needed_libc} ; then
				confgcc+=(
					"${confgcc_no_libc[@]}"
					--disable-threads
					--without-headers
				)
			elif has_version "${CATEGORY}/${needed_libc}[headers-only(-)]" ; then
				confgcc+=(
					"${confgcc_no_libc[@]}"
					--with-sysroot="${PREFIX}"/${CTARGET}
				)
			else
				confgcc+=( --with-sysroot="${PREFIX}"/${CTARGET} )
			fi
		fi

		tc_version_is_at_least 4.2 && confgcc+=( --disable-bootstrap )
	else
		if tc-is-static-only ; then
			confgcc+=( --disable-shared )
		else
			confgcc+=( --enable-shared )
		fi
		case ${CHOST} in
		mingw*|*-mingw*|*-cygwin)
			confgcc+=( --enable-threads=win32 ) ;;
		*)
			confgcc+=( --enable-threads=posix ) ;;
		esac
	fi

	# __cxa_atexit is "essential for fully standards-compliant handling of
	# destructors", but apparently requires glibc.
	case ${CTARGET} in
	*-uclibc*)
		confgcc+=(
			--disable-__cxa_atexit
			$(use_enable nptl tls)
		)
		tc_version_is_between 3.3 3.4 && confgcc+=( --enable-sjlj-exceptions )
		if tc_version_is_between 3.4 4.3 ; then
			confgcc+=( --enable-clocale=uclibc )
		fi
		;;
	*-elf|*-eabi)
		confgcc+=( --with-newlib )
		;;
	*-gnu*)
		confgcc+=(
			--enable-__cxa_atexit
			--enable-clocale=gnu
		)
		;;
	*-freebsd*)
		confgcc+=( --enable-__cxa_atexit )
		;;
	*-solaris*)
		confgcc+=( --enable-__cxa_atexit )
		;;
	esac

	### arch options

	# gcc has fixed-point arithmetic support in 4.3 for mips targets that can
	# significantly increase compile time by several hours.  This will allow
	# users to control this feature in the event they need the support.
	tc_version_is_at_least 4.3 && use fixed-point && confgcc+=( $(use_enable fixed-point) )

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

	local with_abi_map=()
	case $(tc-arch) in
	arm)	#264534 #414395
		local a arm_arch=${CTARGET%%-*}
		# Remove trailing endian variations first: eb el be bl b l
		for a in e{b,l} {b,l}e b l ; do
			if [[ ${arm_arch} == *${a} ]] ; then
				arm_arch=${arm_arch%${a}}
				break
			fi
		done
		# Convert armv7{a,r,m} to armv7-{a,r,m}
		[[ ${arm_arch} == armv7? ]] && arm_arch=${arm_arch/7/7-}
		# See if this is a valid --with-arch flag
		if (srcdir=${S}/gcc target=${CTARGET} with_arch=${arm_arch};
		    . "${srcdir}"/config.gcc) &>/dev/null
		then
			confgcc+=( --with-arch=${arm_arch} )
		fi

		# Make default mode thumb for microcontroller classes #418209
		[[ ${arm_arch} == *-m ]] && confgcc+=( --with-mode=thumb )

		# Enable hardvfp
		if [[ $(tc-is-softfloat) == "no" ]] && \
		   [[ ${CTARGET} == armv[67]* ]] && \
		   tc_version_is_at_least 4.5
		then
			# Follow the new arm hardfp distro standard by default
			confgcc+=( --with-float=hard )
			case ${CTARGET} in
			armv6*) confgcc+=( --with-fpu=vfp ) ;;
			armv7*) confgcc+=( --with-fpu=vfpv3-d16 ) ;;
			esac
		fi
		;;
	amd64)
		# drop the older/ABI checks once this get's merged into some
		# version of gcc upstream
		if tc_version_is_at_least 4.8 && has x32 $(get_all_abis TARGET) ; then
			confgcc+=( --with-abi=$(gcc-abi-map ${TARGET_DEFAULT_ABI}) )
		fi
		;;
	x86)
		# Default arch for x86 is normally i386, lets give it a bump
		# since glibc will do so based on CTARGET anyways
		confgcc+=( --with-arch=${CTARGET%%-*} )
		;;
	esac

	# if the target can do biarch (-m32/-m64), enable it.  overhead should
	# be small, and should simplify building of 64bit kernels in a 32bit
	# userland by not needing sys-devel/kgcc64.  #349405
	case $(tc-arch) in
	amd64|x86) tc_version_is_at_least 4.3 && confgcc+=( --enable-targets=all ) ;;
	esac

	# On Darwin we need libdir to be set in order to get correct install names
	# for things like libobjc-gnu, libgcj and libfortran.  If we enable it on
	# non-Darwin we screw up the behaviour this eclass relies on.  We in
	# particular need this over --libdir for bug #255315.
	[[ ${CTARGET} == *-darwin* ]] && \
		confgcc+=( --enable-version-specific-runtime-libs )

	### library options

	if ! is_gcj ; then
		confgcc+=( --disable-libgcj )
	elif use awt ; then
		confgcc+=( --enable-java-awt=gtk )
	fi

	if tc_version_is_at_least 4.2 ; then
		if use openmp ; then
			# Make sure target has pthreads support. #326757 #335883
			# There shouldn't be a chicken & egg problem here as openmp won't
			# build without a C library, and you can't build that w/out
			# already having a compiler ...
			if ! is_crosscompile || \
			   $(tc-getCPP ${CTARGET}) -E - <<<"#include <pthread.h>" >& /dev/null
			then
				confgcc+=( $(use_enable openmp libgomp) )
			else
				# Force disable as the configure script can be dumb #359855
				confgcc+=( --disable-libgomp )
			fi
		else
			# For gcc variants where we don't want openmp (e.g. kgcc)
			confgcc+=( --disable-libgomp )
		fi
	fi

	if use cilk ; then
		confgcc+=( $(use_enable cilk libcilkrts) )
	fi

	if use mpx ; then
		confgcc+=( $(use_enable mpx libmpx) )
	fi

	if use vtv ; then
		confgcc+=(
			$(use_enable vtv vtable-verify)
			$(use_enable vtv libvtv)
		)
	fi

	# graphite was added in 4.4 but we only support it in 4.8+ due to external
	# library issues.  #448024
	if tc_version_is_at_least 5.0 && use graphite ; then
		confgcc+=( $(use_with graphite isl) )
		use graphite && confgcc+=( --disable-isl-version-check )
	elif tc_version_is_at_least 4.8 && use graphite ; then
		confgcc+=( $(use_with graphite cloog) )
		use graphite && confgcc+=( --disable-isl-version-check )
	elif tc_version_is_at_least 4.4 ; then
		confgcc+=( --without-{cloog,ppl} )
	fi

	if tc_version_is_at_least 4.8 && use sanitize ; then
		confgcc+=( $(use_enable sanitize libsanitizer) )
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
	einfo "STDCXX_INCDIR:   ${STDCXX_INCDIR}"
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

	filter-flags -frecord-gcc-switches # 490738
	filter-flags -mno-rtm -mno-htm # 506202

	append-flags -Wa,--noexecstack

	if tc_version_is_between 3.2 3.4 ; then
		# XXX: this is so outdated it's barely useful, but it don't hurt...
		replace-cpu-flags G3 750
		replace-cpu-flags G4 7400
		replace-cpu-flags G5 7400

		# XXX: should add a sed or something to query all supported flags
		#      from the gcc source and trim everything else ...
		filter-flags -f{no-,}unit-at-a-time -f{no-,}web -mno-tls-direct-seg-refs
		filter-flags -f{no-,}stack-protector{,-all}
		filter-flags -fvisibility-inlines-hidden -fvisibility=hidden
	fi

	strip-unsupported-flags

	# these are set here so we have something sane at configure time
	if is_crosscompile ; then
		# Set this to something sane for both native and target
		CFLAGS="-O2 -pipe"
		FFLAGS=${CFLAGS}
		FCFLAGS=${CFLAGS}

		# "hppa2.0-unknown-linux-gnu" -> hppa2_0_unknown_linux_gnu
		local VAR="CFLAGS_"${CTARGET//[-.]/_}
		CXXFLAGS=${!VAR-${CFLAGS}}
	fi

	export GCJFLAGS=${GCJFLAGS:-${CFLAGS}}
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

	# default target
	if is_crosscompile || tc-is-cross-compiler ; then
		# 3 stage bootstrapping doesnt quite work when you cant run the
		# resulting binaries natively ^^;
		GCC_MAKE_TARGET=${GCC_MAKE_TARGET-all}
	else
		if tc_version_is_at_least 3.3 && use_if_iuse pgo; then
			GCC_MAKE_TARGET=${GCC_MAKE_TARGET-profiledbootstrap}
		else
			GCC_MAKE_TARGET=${GCC_MAKE_TARGET-bootstrap-lean}
		fi
	fi

	# Older versions of GCC could not do profiledbootstrap in parallel due to
	# collisions with profiling info.
	# boundschecking also seems to introduce parallel build issues.
	if [[ ${GCC_MAKE_TARGET} == "profiledbootstrap" ]] || use_if_iuse boundschecking ; then
		! tc_version_is_at_least 4.6 && export MAKEOPTS="${MAKEOPTS} -j1"
	fi

	if [[ ${GCC_MAKE_TARGET} == "all" ]] ; then
		STAGE1_CFLAGS=${STAGE1_CFLAGS-"${CFLAGS}"}
	fi

	if is_crosscompile; then
		# In 3.4, BOOT_CFLAGS is never used on a crosscompile...
		# but I'll leave this in anyways as someone might have had
		# some reason for putting it in here... --eradicator
		BOOT_CFLAGS=${BOOT_CFLAGS-"-O2"}
	else
		# we only want to use the system's CFLAGS if not building a
		# cross-compiler.
		BOOT_CFLAGS=${BOOT_CFLAGS-"$(get_abi_CFLAGS ${TARGET_DEFAULT_ABI}) ${CFLAGS}"}
	fi

	einfo "Compiling ${PN} (${GCC_MAKE_TARGET})..."

	pushd "${WORKDIR}"/build >/dev/null

	emake \
		LDFLAGS="${LDFLAGS}" \
		STAGE1_CFLAGS="${STAGE1_CFLAGS}" \
		LIBPATH="${LIBPATH}" \
		BOOT_CFLAGS="${BOOT_CFLAGS}" \
		${GCC_MAKE_TARGET} \
		|| die "emake failed with ${GCC_MAKE_TARGET}"

	popd >/dev/null
}

#---->> src_test <<----

toolchain_src_test() {
	if use regression-test ; then
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

	# Move the libraries to the proper location
	gcc_movelibs

	# Basic sanity check
	if ! is_crosscompile ; then
		local EXEEXT
		eval $(grep ^EXEEXT= "${WORKDIR}"/build/gcc/config.log)
		[[ -r ${D}${BINPATH}/gcc${EXEEXT} ]] || die "gcc not found in ${D}"
	fi

	dodir /etc/env.d/gcc
	create_gcc_env_entry

	# Make sure we dont have stuff lying around that
	# can nuke multiple versions of gcc
	gcc_slot_java

	dodir /usr/bin
	cd "${D}"${BINPATH}
	# Ugh: we really need to auto-detect this list.
	#      It's constantly out of date.
	for x in cpp gcc g++ c++ gcov g77 gcj gcjh gfortran gccgo ; do
		# For some reason, g77 gets made instead of ${CTARGET}-g77...
		# this should take care of that
		if [[ -f ${x} ]] ; then
			# In case they're hardlinks, clear out the target first
			# otherwise the mv below will complain.
			rm -f ${CTARGET}-${x}
			mv ${x} ${CTARGET}-${x}
		fi

		if [[ -f ${CTARGET}-${x} ]] ; then
			if ! is_crosscompile ; then
				ln -sf ${CTARGET}-${x} ${x}
				dosym ${BINPATH#${EPREFIX}}/${CTARGET}-${x} \
					/usr/bin/${x}-${GCC_CONFIG_VER}
			fi
			# Create versioned symlinks
			dosym ${BINPATH#${EPREFIX}}/${CTARGET}-${x} \
				/usr/bin/${CTARGET}-${x}-${GCC_CONFIG_VER}
		fi

		if [[ -f ${CTARGET}-${x}-${GCC_CONFIG_VER} ]] ; then
			rm -f ${CTARGET}-${x}-${GCC_CONFIG_VER}
			ln -sf ${CTARGET}-${x} ${CTARGET}-${x}-${GCC_CONFIG_VER}
		fi
	done

	# Now do the fun stripping stuff
	env RESTRICT="" CHOST=${CHOST} prepstrip "${D}${BINPATH}"
	is_crosscompile && \
		env RESTRICT="" CHOST=${CHOST} prepstrip "${D}${HOSTLIBPATH}"
	env RESTRICT="" CHOST=${CTARGET} prepstrip "${D}${LIBPATH}"
	# gcc used to install helper binaries in lib/ but then moved to libexec/
	[[ -d ${D}${PREFIX}/libexec/gcc ]] && \
		env RESTRICT="" CHOST=${CHOST} prepstrip "${D}${PREFIX}/libexec/gcc/${CTARGET}/${GCC_CONFIG_VER}"

	cd "${S}"
	if is_crosscompile; then
		rm -rf "${ED}"usr/share/{man,info}
		rm -rf "${D}"${DATAPATH}/{man,info}
	else
		has noinfo ${FEATURES} \
			&& rm -r "${D}${DATAPATH}"/info \
			|| prepinfo "${DATAPATH#${EPREFIX}}"
		has noman ${FEATURES} \
			&& rm -r "${D}${DATAPATH}"/man \
			|| prepman "${DATAPATH#${EPREFIX}}"
	fi
	# prune empty dirs left behind
	find "${D}" -depth -type d -delete 2>/dev/null

	# install testsuite results
	if use regression-test; then
		docinto testsuite
		find "${WORKDIR}"/build -type f -name "*.sum" -exec dodoc {} +
		find "${WORKDIR}"/build -type f -path "*/testsuite/*.log" -exec dodoc {} +
	fi

	# Rather install the script, else portage with changing $FILESDIR
	# between binary and source package borks things ....
	if ! is_crosscompile && [[ ${PN} != "kgcc64" ]] ; then
		insinto "${DATAPATH#${EPREFIX}}"
		newins "$(prefixify_ro "${FILESDIR}"/awk/fixlafiles.awk-no_gcc_la)" fixlafiles.awk || die
		exeinto "${DATAPATH#${EPREFIX}}"
		doexe "$(prefixify_ro "${FILESDIR}"/fix_libtool_files.sh)" || die
		doexe "${FILESDIR}"/c{89,99} || die
	fi

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
	# libmpx.la: gcc itself handles linkage correctly (libmpx.spec).
	# libmpxwrappers.la: See above.
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
			-name libmpx.la -o \
			-name libmpxwrappers.la -o \
			-name libitm.la -o \
			-name libvtv.la -o \
			-name 'lib*san.la' \
		')' -type f -delete

	# Use gid of 0 because some stupid ports don't have
	# the group 'root' set to gid 0.  Send to /dev/null
	# for people who are testing as non-root.
	chown -R root:0 "${D}${LIBPATH}" 2>/dev/null

	# Move pretty-printers to gdb datadir to shut ldconfig up
	local py gdbdir=/usr/share/gdb/auto-load${LIBPATH/\/lib\//\/$(get_libdir)\/}
	pushd "${D}${LIBPATH}" >/dev/null
	for py in $(find . -name '*-gdb.py') ; do
		local multidir=${py%/*}
		insinto "${gdbdir}/${multidir}"
		sed -i "/^libdir =/s:=.*:= '${LIBPATH}/${multidir}':" "${py}" || die #348128
		doins "${py}" || die
		rm "${py}" || die
	done
	popd >/dev/null

	# Don't scan .gox files for executable stacks - false positives
	export QA_EXECSTACK="usr/lib*/go/*/*.gox"
	export QA_WX_LOAD="usr/lib*/go/*/*.gox"

	#fperms 444 /usr/lib/gcc/x86_64-pc-linux-gnu/${PV}/libgcc.a

	chrpath -r /usr/lib64 "${ED}"/usr/lib/gcc/x86_64-pc-linux-gnu/8.2.9999/libstdc++.so.6.0.25
}

# Move around the libs to the right location.  For some reason,
# when installing gcc, it dumps internal libraries into /usr/lib
# instead of the private gcc lib path
gcc_movelibs() {
	# For non-target libs which are for CHOST and not CTARGET, we want to
	# move them to the compiler-specific CHOST internal dir.  This is stuff
	# that you want to link against when building tools rather than building
	# code to run on the target.
	if tc_version_is_at_least 5 && is_crosscompile ; then
		dodir "${HOSTLIBPATH#${EPREFIX}}"
		mv "${ED}"usr/$(get_libdir)/libcc1* "${D}${HOSTLIBPATH}" || die
	fi

	# For all the libs that are built for CTARGET, move them into the
	# compiler-specific CTARGET internal dir.
	local x multiarg removedirs=""
	for multiarg in $($(XGCC) -print-multi-lib) ; do
		multiarg=${multiarg#*;}
		multiarg=${multiarg//@/ -}

		local OS_MULTIDIR=$($(XGCC) ${multiarg} --print-multi-os-directory)
		local MULTIDIR=$($(XGCC) ${multiarg} --print-multi-directory)
		local TODIR="${D}${LIBPATH}"/${MULTIDIR}
		local FROMDIR=

		[[ -d ${TODIR} ]] || mkdir -p ${TODIR}

		for FROMDIR in \
			"${LIBPATH}"/${OS_MULTIDIR} \
			"${LIBPATH}"/../${MULTIDIR} \
			"${PREFIX}"/lib/${OS_MULTIDIR} \
			"${PREFIX}"/${CTARGET}/lib/${OS_MULTIDIR}
		do
			removedirs="${removedirs} ${FROMDIR}"
			FROMDIR=${D}${FROMDIR}
			if [[ ${FROMDIR} != "${TODIR}" && -d ${FROMDIR} ]] ; then
				local files=$(find "${FROMDIR}" -maxdepth 1 ! -type d 2>/dev/null)
				if [[ -n ${files} ]] ; then
					mv ${files} "${TODIR}" || die
				fi
			fi
		done
		fix_libtool_libdir_paths "${LIBPATH}/${MULTIDIR}"

		# SLOT up libgcj.pc if it's available (and let gcc-config worry about links)
		FROMDIR="${PREFIX}/lib/${OS_MULTIDIR}"
		for x in "${D}${FROMDIR}"/pkgconfig/libgcj*.pc ; do
			[[ -f ${x} ]] || continue
			sed -i "/^libdir=/s:=.*:=${LIBPATH}/${MULTIDIR}:" "${x}" || die
			mv "${x}" "${D}${FROMDIR}"/pkgconfig/libgcj-${GCC_PV}.pc || die
		done
	done

	for FROMDIR in ${removedirs} ; do
		rmdir "${D}"${FROMDIR} >& /dev/null
	done
	find -depth "${D}" -type d -exec rmdir {} + >& /dev/null
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

create_gcc_env_entry() {
	dodir /etc/env.d/gcc
	local gcc_envd_base="/etc/env.d/gcc/${CTARGET}-${GCC_CONFIG_VER}"

	local gcc_envd_file="${ED}${gcc_envd_base}"

	local ldpaths

	ldpaths=${LIBPATH}

	cat <<-EOF > ${gcc_envd_file}
	PATH="${BINPATH}"
	ROOTPATH="${BINPATH}"
	GCC_PATH="${BINPATH}"
	LDPATH="${ldpaths}"
	MANPATH="${DATAPATH}/man"
	INFOPATH="${DATAPATH}/info"
	STDCXX_INCDIR="${STDCXX_INCDIR##*/}"
	CTARGET="${CTARGET}"
	MULTIOSDIRS="${mosdirs}"
	EOF
}

gcc_slot_java() {
	local x

	# Move Java headers to compiler-specific dir
	for x in "${D}${PREFIX}"/include/gc*.h "${D}${PREFIX}"/include/j*.h ; do
		[[ -f ${x} ]] && mv -f "${x}" "${D}${LIBPATH}"/include/
	done
	for x in gcj gnu java javax org ; do
		if [[ -d ${D}${PREFIX}/include/${x} ]] ; then
			dodir /${LIBPATH#${EPREFIX}}/include/${x}
			mv -f "${D}${PREFIX}"/include/${x}/* "${D}${LIBPATH}"/include/${x}/
			rm -rf "${D}${PREFIX}"/include/${x}
		fi
	done

	if [[ -d ${D}${PREFIX}/lib/security ]] || [[ -d ${D}${PREFIX}/$(get_libdir)/security ]] ; then
		dodir /${LIBPATH#${EPREFIX}}/security
		mv -f "${D}${PREFIX}"/lib*/security/* "${D}${LIBPATH}"/security
		rm -rf "${D}${PREFIX}"/lib*/security
	fi

	# Move random gcj files to compiler-specific directories
	for x in libgcj.spec logging.properties ; do
		x="${D}${PREFIX}/lib/${x}"
		[[ -f ${x} ]] && mv -f "${x}" "${D}${LIBPATH}"/
	done

	# Rename jar because it could clash with Kaffe's jar if this gcc is
	# primary compiler (aka don't have the -<version> extension)
	cd "${D}${BINPATH}"
	[[ -f jar ]] && mv -f jar gcj-jar
}

#---->> pkg_post* <<----

toolchain_pkg_postinst() {
	do_gcc_config
	if [[ ${ROOT} == / && -f ${EPREFIX}/usr/share/eselect/modules/compiler-shadow.eselect ]] ; then
		eselect compiler-shadow update all
	fi

	if ! is_crosscompile && [[ ${PN} != "kgcc64" ]] ; then
		# Clean up old paths
		rm -f "${EROOT}"*/rcscripts/awk/fixlafiles.awk "${EROOT}"sbin/fix_libtool_files.sh
		rmdir "${EROOT}"*/rcscripts{/awk,} 2>/dev/null

		mkdir -p "${EROOT}"usr/{share/gcc-data,sbin,bin}
		# DATAPATH has EPREFIX already, use ROOT with it
		cp "${ROOT}${DATAPATH}"/fixlafiles.awk "${EROOT}"usr/share/gcc-data/ || die
		cp "${ROOT}${DATAPATH}"/fix_libtool_files.sh "${EROOT}"usr/sbin/ || die

		# Since these aren't critical files and portage sucks with
		# handling of binpkgs, don't require these to be found
		cp "${ROOT}${DATAPATH}"/c{89,99} "${EROOT}"usr/bin/ 2>/dev/null
	fi

	if use regression-test ; then
		elog "Testsuite results have been installed into /usr/share/doc/${PF}/testsuite"
		echo
	fi
}

toolchain_pkg_postrm() {
	if [[ ${ROOT} == / && -f ${EPREFIX}/usr/share/eselect/modules/compiler-shadow.eselect ]] ; then
		eselect compiler-shadow clean all
	fi

	# to make our lives easier (and saner), we do the fix_libtool stuff here.
	# rather than checking SLOT's and trying in upgrade paths, we just see if
	# the common libstdc++.la exists in the ${LIBPATH} of the gcc that we are
	# unmerging.  if it does, that means this was a simple re-emerge.

	# clean up the cruft left behind by cross-compilers
	if is_crosscompile ; then
		if [[ -z $(ls "${EROOT}"etc/env.d/gcc/${CTARGET}* 2>/dev/null) ]] ; then
			rm -f "${EROOT}"etc/env.d/gcc/config-${CTARGET}
			rm -f "${EROOT}"etc/env.d/??gcc-${CTARGET}
			rm -f "${EROOT}"usr/bin/${CTARGET}-{gcc,{g,c}++}{,32,64}
		fi
		return 0
	fi

	# ROOT isnt handled by the script
	[[ ${ROOT} != "/" ]] && return 0

	if [[ ! -e ${LIBPATH}/libstdc++.so ]] ; then
		# make sure the profile is sane during same-slot upgrade #289403
		do_gcc_config

		einfo "Running 'fix_libtool_files.sh ${GCC_RELEASE_VER}'"
		fix_libtool_files.sh ${GCC_RELEASE_VER}
		if [[ -n ${BRANCH_UPDATE} ]] ; then
			einfo "Running 'fix_libtool_files.sh ${GCC_RELEASE_VER}-${BRANCH_UPDATE}'"
			fix_libtool_files.sh ${GCC_RELEASE_VER}-${BRANCH_UPDATE}
		fi
	fi

	return 0
}

do_gcc_config() {
	if ! should_we_gcc_config ; then
		gcc-config --use-old --force
		return 0
	fi

	local current_gcc_config target

	gcc-config "${target}"
}

should_we_gcc_config() {
	# if the previously selected config has the same major.minor (branch) as
	# the version we are installing, then it will probably be uninstalled
	# for being in the same SLOT, make sure we run gcc-config.
	local curr_config_ver=$(gcc-config -S ${curr_config} | awk '{print $2}')

	local curr_branch_ver=$(get_version_component_range 1-2 ${curr_config_ver})

	if [[ ${curr_branch_ver} == ${GCC_BRANCH_VER} ]] ; then
		return 0
	else
		# if we're installing a genuinely different compiler version,
		# we should probably tell the user -how- to switch to the new
		# gcc version, since we're not going to do it for him/her.
		# We don't want to switch from say gcc-3.3 to gcc-3.4 right in
		# the middle of an emerge operation (like an 'emerge -e world'
		# which could install multiple gcc versions).
		# Only warn if we're installing a pkg as we might be called from
		# the pkg_{pre,post}rm steps.  #446830
		if [[ ${EBUILD_PHASE} == *"inst" ]] ; then
			einfo "The current gcc config appears valid, so it will not be"
			einfo "automatically switched for you.  If you would like to"
			einfo "switch to the newly installed gcc version, do the"
			einfo "following:"
			echo
			einfo "gcc-config ${CTARGET}-${GCC_CONFIG_VER}"
			einfo "source /etc/profile"
			echo
		fi
		return 1
	fi
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

is_ada() {
	gcc-lang-supported ada || return 1
	use_if_iuse ada
}

is_cxx() {
	gcc-lang-supported 'c++' || return 1
	! is_crosscompile && tc_version_is_at_least 4.8 && return 0
	use_if_iuse cxx
}

is_d() {
	gcc-lang-supported d || return 1
	use_if_iuse d
}

is_f77() {
	gcc-lang-supported f77 || return 1
	use_if_iuse fortran
}

is_f95() {
	gcc-lang-supported f95 || return 1
	use_if_iuse fortran
}

is_fortran() {
	gcc-lang-supported fortran || return 1
	use_if_iuse fortran
}

is_gcj() {
	gcc-lang-supported java || return 1
	use_if_iuse cxx && use_if_iuse gcj
}

is_go() {
	gcc-lang-supported go || return 1
	use_if_iuse cxx && use_if_iuse go
}

is_jit() {
	gcc-lang-supported jit || return 1
	use_if_iuse jit
}

is_objc() {
	gcc-lang-supported objc || return 1
	use_if_iuse objc
}

is_objcxx() {
	gcc-lang-supported 'obj-c++' || return 1
	use_if_iuse cxx && use_if_iuse objc++
}

# Grab a variable from the build system (taken from linux-info.eclass)
get_make_var() {
	local var=$1 makefile=${2:-${WORKDIR}/build/Makefile}
	echo -e "e:\\n\\t@echo \$(${var})\\ninclude ${makefile}" | \
		r=${makefile%/*} emake --no-print-directory -s -f - 2>/dev/null
}

XGCC() { get_make_var GCC_FOR_TARGET ; }


