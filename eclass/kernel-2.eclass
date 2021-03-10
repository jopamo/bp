# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_{7,8} )

inherit toolchain-funcs python-any-r1

[[ ${EAPI:-0} == [01234567] ]] && inherit estack
case ${EAPI:-0} in
	6|7)
		EXPORT_FUNCTIONS src_{unpack,compile,install,test} \
			pkg_{setup,preinst,postinst,postrm} ;;
	*) die "${ECLASS}: EAPI ${EAPI} not supported" ;;
esac

export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} && ${CATEGORY/cross-} != ${CATEGORY} ]]; then
	export CTARGET=${CATEGORY/cross-}
fi

HOMEPAGE="https://www.kernel.org/ ${HOMEPAGE}"
: ${LICENSE:="GPL-2"}

# No need to run scanelf/strip on kernel sources/headers (bug #134453).
RESTRICT="binchecks strip"

# @FUNCTION: debug-print-kernel2-variables
# @USAGE:
# @DESCRIPTION:
# this function exists only to help debug kernel-2.eclass
# if you are adding new functionality in, put a call to it
# at the start of src_unpack, or during SRC_URI/dep generation.

debug-print-kernel2-variables() {
	for v in PVR CKV OKV KV KV_FULL KV_MAJOR KV_MINOR KV_PATCH RELEASETYPE \
			RELEASE S KERNEL_URI ; do
		debug-print "${v}: ${!v}"
	done
}

# @FUNCTION: detect_version
# @USAGE:
# @DESCRIPTION:
# this function will detect and set
# - OKV: Original Kernel Version (2.6.0/2.6.0-test11)
# - KV: Kernel Version (2.6.0-gentoo/2.6.0-test11-gentoo-r1)
# - EXTRAVERSION: The additional version appended to OKV (-gentoo/-gentoo-r1)
detect_version() {

	# We've already run, so nothing to do here.
	[[ -n ${KV_FULL} ]] && return 0

	# CKV is used as a comparison kernel version, which is used when
	# PV doesnt reflect the genuine kernel version.
	# this gets set to the portage style versioning. ie:
	#   CKV=2.6.11_rc4
	CKV=${CKV:-${PV}}
	OKV=${OKV:-${CKV}}
	OKV=${OKV/_beta/-test}
	OKV=${OKV/_rc/-rc}
	OKV=${OKV/-r*}
	OKV=${OKV/_p*}

	KV_MAJOR=$(ver_cut 1 ${OKV})
	# handle if OKV is X.Y or X.Y.Z (e.g. 3.0 or 3.0.1)
	local OKV_ARRAY
	IFS="." read -r -a OKV_ARRAY <<<"${OKV}"

	# if KV_MAJOR >= 3, then we have no more KV_MINOR
	#if [[ ${KV_MAJOR} -lt 3 ]]; then
	if [[ ${#OKV_ARRAY[@]} -ge 3 ]]; then
		KV_MINOR=$(ver_cut 2 ${OKV})
		KV_PATCH=$(ver_cut 3 ${OKV})
		if [[ ${KV_MAJOR}${KV_MINOR}${KV_PATCH} -ge 269 ]]; then
			KV_EXTRA=$(ver_cut 4- ${OKV})
			KV_EXTRA=${KV_EXTRA/[-_]*}
		else
			KV_PATCH=$(ver_cut 3- ${OKV})
		fi
	else
		KV_PATCH=$(ver_cut 2 ${OKV})
		KV_EXTRA=$(ver_cut 3- ${OKV})
		KV_EXTRA=${KV_EXTRA/[-_]*}
	fi

	debug-print "KV_EXTRA is ${KV_EXTRA}"

	KV_PATCH=${KV_PATCH/[-_]*}

	local v n=0 missing
	#if [[ ${KV_MAJOR} -lt 3 ]]; then
	if [[ ${#OKV_ARRAY[@]} -ge 3 ]]; then
		for v in CKV OKV KV_{MAJOR,MINOR,PATCH} ; do
			[[ -z ${!v} ]] && n=1 && missing="${missing}${v} ";
		done
	else
		for v in CKV OKV KV_{MAJOR,PATCH} ; do
			[[ -z ${!v} ]] && n=1 && missing="${missing}${v} ";
		done
	fi

	[[ $n -eq 1 ]] && \
		eerror "Missing variables: ${missing}" && \
		die "Failed to extract kernel version (try explicit CKV in ebuild)!"
	unset v n missing

#	if [[ ${KV_MAJOR} -ge 3 ]]; then
	if [[ ${#OKV_ARRAY[@]} -lt 3 ]]; then
		KV_PATCH_ARR=(${KV_PATCH//\./ })

		# at this point 031412, Linus is putting all 3.x kernels in a
		# 3.x directory, may need to revisit when 4.x is released
		KERNEL_BASE_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.x"

		[[ -n "${K_LONGTERM}" ]] &&
			KERNEL_BASE_URI="${KERNEL_BASE_URI}/longterm/v${KV_MAJOR}.${KV_PATCH_ARR}"
	else
		#KERNEL_BASE_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.0"
		#KERNEL_BASE_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}"
		if [[ ${KV_MAJOR} -ge 3 ]]; then
			KERNEL_BASE_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.x"
		else
			KERNEL_BASE_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}"
		fi

		[[ -n "${K_LONGTERM}" ]] &&
			#KERNEL_BASE_URI="${KERNEL_BASE_URI}/longterm"
			KERNEL_BASE_URI="${KERNEL_BASE_URI}/longterm/v${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}"
	fi

	debug-print "KERNEL_BASE_URI is ${KERNEL_BASE_URI}"

	if [[ ${#OKV_ARRAY[@]} -ge 3 ]] && [[ ${KV_MAJOR} -ge 3 ]]; then
		KERNEL_URI="${KERNEL_URI} ${KERNEL_BASE_URI}/linux-${KV_MAJOR}.${KV_MINOR}.tar.xz"
	else
		KERNEL_URI="${KERNEL_BASE_URI}/linux-${OKV}.tar.xz"
	fi

	RELEASE=${CKV/${OKV}}
	RELEASE=${RELEASE/_beta}
	RELEASE=${RELEASE/_rc/-rc}
	RELEASE=${RELEASE/_pre/-pre}
	# We cannot trivally call kernel_is here, because it calls us to detect the
	# version
	#kernel_is ge 2 6 && RELEASE=${RELEASE/-pre/-git}
	[ $(($KV_MAJOR * 1000 + ${KV_MINOR:-0})) -ge 2006 ] && RELEASE=${RELEASE/-pre/-git}
	RELEASETYPE=${RELEASE//[0-9]}

	# Now we know that RELEASE is the -rc/-git
	# and RELEASETYPE is the same but with its numerics stripped
	# we can work on better sorting EXTRAVERSION.
	# first of all, we add the release
	EXTRAVERSION="${RELEASE}"
	debug-print "0 EXTRAVERSION:${EXTRAVERSION}"
	[[ -n ${KV_EXTRA} ]] && [[ ${KV_MAJOR} -lt 3 ]] && EXTRAVERSION=".${KV_EXTRA}${EXTRAVERSION}"

	debug-print "1 EXTRAVERSION:${EXTRAVERSION}"
	if [[ -n "${K_NOUSEPR}" ]]; then
		# Don't add anything based on PR to EXTRAVERSION
		debug-print "1.0 EXTRAVERSION:${EXTRAVERSION}"
	elif [[ -n ${K_PREPATCHED} ]]; then
		debug-print "1.1 EXTRAVERSION:${EXTRAVERSION}"
		EXTRAVERSION="${EXTRAVERSION}-${PN/-*}${PR/r}"
	elif [[ "${ETYPE}" = "sources" ]]; then
		debug-print "1.2 EXTRAVERSION:${EXTRAVERSION}"
		# For some sources we want to use the PV in the extra version
		# This is because upstream releases with a completely different
		# versioning scheme.
		case ${PN/-*} in
		     wolk) K_USEPV=1;;
		  vserver) K_USEPV=1;;
		esac

		[[ -z "${K_NOUSENAME}" ]] && EXTRAVERSION="${EXTRAVERSION}-${PN/-*}"
		[[ -n "${K_USEPV}" ]]     && EXTRAVERSION="${EXTRAVERSION}-${PV//_/-}"
		[[ -n "${PR//r0}" ]] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
	fi
	debug-print "2 EXTRAVERSION:${EXTRAVERSION}"

	# The only messing around which should actually effect this is for KV_EXTRA
	# since this has to limit OKV to MAJ.MIN.PAT and strip EXTRA off else
	# KV_FULL evaluates to MAJ.MIN.PAT.EXT.EXT after EXTRAVERSION

	if [[ -n ${KV_EXTRA} ]]; then
		if [[ -n ${KV_MINOR} ]]; then
			OKV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}"
		else
			OKV="${KV_MAJOR}.${KV_PATCH}"
		fi
		KERNEL_URI="${KERNEL_BASE_URI}/patch-${CKV}.xz
					${KERNEL_BASE_URI}/linux-${OKV}.tar.xz"
	fi

	# We need to set this using OKV, but we need to set it before we do any
	# messing around with OKV based on RELEASETYPE
	KV_FULL=${OKV}${EXTRAVERSION}

	# we will set this for backwards compatibility.
	S="${WORKDIR}"/linux-${KV_FULL}
	KV=${KV_FULL}

	# -rc-git pulls can be achieved by specifying CKV
	# for example:
	#   CKV="2.6.11_rc3_pre2"
	# will pull:
	#   linux-2.6.10.tar.xz & patch-2.6.11-rc3.xz & patch-2.6.11-rc3-git2.xz

	if [[ ${KV_MAJOR}${KV_MINOR} -eq 26 ]]; then

		if [[ ${RELEASETYPE} == -rc ]] || [[ ${RELEASETYPE} == -pre ]]; then
			OKV="${KV_MAJOR}.${KV_MINOR}.$((${KV_PATCH} - 1))"
			KERNEL_URI="${KERNEL_BASE_URI}/testing/patch-${CKV//_/-}.xz
						${KERNEL_BASE_URI}/linux-${OKV}.tar.xz"
		fi

		if [[ ${RELEASETYPE} == -git ]]; then
			KERNEL_URI="${KERNEL_BASE_URI}/snapshots/patch-${OKV}${RELEASE}.xz
						${KERNEL_BASE_URI}/linux-${OKV}.tar.xz"
		fi

		if [[ ${RELEASETYPE} == -rc-git ]]; then
			OKV="${KV_MAJOR}.${KV_MINOR}.$((${KV_PATCH} - 1))"
			KERNEL_URI="${KERNEL_BASE_URI}/snapshots/patch-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}${RELEASE}.xz
						${KERNEL_BASE_URI}/testing/patch-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}${RELEASE/-git*}.xz
						${KERNEL_BASE_URI}/linux-${OKV}.tar.xz"
		fi
	else
		KV_PATCH_ARR=(${KV_PATCH//\./ })

		# the different majorminor versions have different patch start versions
		OKV_DICT=(["2"]="${KV_MAJOR}.$((${KV_PATCH_ARR} - 1))" ["3"]="2.6.39" ["4"]="3.19")

		if [[ ${RELEASETYPE} == -rc ]] || [[ ${RELEASETYPE} == -pre ]]; then

			OKV=${K_BASE_VER:-$OKV_DICT["${KV_MAJOR}"]}

			# as of 12/5/2017, the rc patch is no longer offered as a compressed
			# file, and no longer is it mirrored on kernel.org
			if ver_test "${KV_MAJOR}.${KV_PATCH}" -ge "4.12"; then
				KERNEL_URI="https://git.kernel.org/torvalds/p/v${KV_FULL}/v${OKV} -> patch-${KV_FULL}.patch
							${KERNEL_BASE_URI}/linux-${OKV}.tar.xz"
			else
				KERNEL_URI="${KERNEL_BASE_URI}/testing/patch-${CKV//_/-}.xz
							${KERNEL_BASE_URI}/linux-${OKV}.tar.xz"
			fi
		fi

		if [[ ${RELEASETYPE} == -git ]]; then
			KERNEL_URI="${KERNEL_BASE_URI}/snapshots/patch-${OKV}${RELEASE}.xz
						${KERNEL_BASE_URI}/linux-${OKV}.tar.xz"
		fi

		if [[ ${RELEASETYPE} == -rc-git ]]; then
			OKV=${K_BASE_VER:-$OKV_DICT["${KV_MAJOR}"]}
			KERNEL_URI="${KERNEL_BASE_URI}/snapshots/patch-${KV_MAJOR}.${KV_PATCH}${RELEASE}.xz
						${KERNEL_BASE_URI}/testing/patch-${KV_MAJOR}.${KV_PATCH}${RELEASE/-git*}.xz
						${KERNEL_BASE_URI}/linux-${OKV}.tar.xz"
		fi


	fi

	debug-print-kernel2-variables
}

# Capture the sources type and set DEPENDs
if [[ ${ETYPE} == sources ]]; then
	DEPEND="!build? (
		sys-app/sed
		>=sys-devel/binutils-2.11.90.0.31
	)"
	RDEPEND="!build? (
		dev-lang/perl
		sys-devel/bc
		sys-devel/bison
		sys-devel/flex
		sys-devel/make
		lib-sys/ncurses
	)"

	SLOT="${PVR}"
	DESCRIPTION="Sources based on the Linux Kernel."
	IUSE="symlink build"

elif [[ ${ETYPE} == headers ]]; then
	DESCRIPTION="Linux system headers"
	IUSE="headers-only"

	# Since we should NOT honour KBUILD_OUTPUT in headers
	# lets unset it here.
	unset KBUILD_OUTPUT

	SLOT="0"
fi

# Cross-compile support functions

# @FUNCTION: kernel_header_destdir
# @USAGE:
# @DESCRIPTION:
# return header destination directory
kernel_header_destdir() {
	[[ ${CTARGET} == ${CHOST} ]] \
		&& echo usr/include \
		|| echo usr/${CTARGET}/usr/include
}

# @FUNCTION: cross_pre_c_headers
# @USAGE:
# @DESCRIPTION:
# set use if necessary for cross compile support
cross_pre_c_headers() {
	use headers-only && [[ ${CHOST} != ${CTARGET} ]]
}

# @FUNCTION: env_setup_xmakeopts
# @USAGE:
# @DESCRIPTION:
# set the ARCH/CROSS_COMPILE when cross compiling

env_setup_xmakeopts() {
	# Kernel ARCH != portage ARCH
	export KARCH=$(tc-arch-kernel)

	# When cross-compiling, we need to set the ARCH/CROSS_COMPILE
	# variables properly or bad things happen !
	xmakeopts="ARCH=${KARCH}"
	if [[ ${CTARGET} != ${CHOST} ]] && ! cross_pre_c_headers ; then
		xmakeopts="${xmakeopts} CROSS_COMPILE=${CTARGET}-"
	elif type -p ${CHOST}-ar > /dev/null ; then
		xmakeopts="${xmakeopts} CROSS_COMPILE=${CHOST}-"
	fi
	export xmakeopts
}

# @FUNCTION: universal_unpack
# @USAGE:
# @DESCRIPTION:
# unpack kernel sources

universal_unpack() {
	debug-print "Inside universal_unpack"

	local OKV_ARRAY
	IFS="." read -r -a OKV_ARRAY <<<"${OKV}"

	cd "${WORKDIR}"
	if [[ ${#OKV_ARRAY[@]} -ge 3 ]] && [[ ${KV_MAJOR} -ge 3 ]]; then
		unpack linux-${KV_MAJOR}.${KV_MINOR}.tar.xz
	else
		unpack linux-${OKV}.tar.xz
	fi

	if [[ -d "linux" ]]; then
		debug-print "Moving linux to linux-${KV_FULL}"
		mv linux linux-${KV_FULL} \
			|| die "Unable to move source tree to ${KV_FULL}."
	elif [[ "${OKV}" != "${KV_FULL}" ]]; then
		if [[ ${#OKV_ARRAY[@]} -ge 3 ]] && [[ ${KV_MAJOR} -ge 3 ]] &&
			[[ "${ETYPE}" = "sources" ]]; then
			debug-print "moving linux-${KV_MAJOR}.${KV_MINOR} to linux-${KV_FULL} "
			mv linux-${KV_MAJOR}.${KV_MINOR} linux-${KV_FULL} \
				|| die "Unable to move source tree to ${KV_FULL}."
		else
			debug-print "moving linux-${OKV} to linux-${KV_FULL} "
			mv linux-${OKV} linux-${KV_FULL} \
				|| die "Unable to move source tree to ${KV_FULL}."
		fi
	elif [[ ${#OKV_ARRAY[@]} -ge 3 ]] && [[ ${KV_MAJOR} -ge 3 ]]; then
		mv linux-${KV_MAJOR}.${KV_MINOR} linux-${KV_FULL} \
			|| die "Unable to move source tree to ${KV_FULL}."
	fi
	cd "${S}"

	# remove all backup files
	find . -iname "*~" -exec rm {} \; 2> /dev/null

}

# @FUNCTION: unpack_set_extraversion
# @USAGE:
# @DESCRIPTION:
# handle EXTRAVERSION

unpack_set_extraversion() {
	cd "${S}"
	sed -i -e "s:^\(EXTRAVERSION =\).*:\1 ${EXTRAVERSION}:" Makefile
	cd "${OLDPWD}"
}

# @FUNCTION: unpack_fix_install_path
# @USAGE:
# @DESCRIPTION:
# Should be done after patches have been applied
# Otherwise patches that modify the same area of Makefile will fail

unpack_fix_install_path() {
	cd "${S}"
	sed	-i -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' Makefile
}

# Compile Functions

# @FUNCTION: compile_headers
# @USAGE:
# @DESCRIPTION:
# header compilation

compile_headers() {
	env_setup_xmakeopts

	# if we couldnt obtain HOSTCFLAGS from the Makefile,
	# then set it to something sane
	local HOSTCFLAGS=$(getfilevar HOSTCFLAGS "${S}"/Makefile)
	HOSTCFLAGS=${HOSTCFLAGS:--Wall -Wstrict-prototypes -O2 -fomit-frame-pointer}
}

# @FUNCTION: compile_headers_tweak_config
# @USAGE:
# @DESCRIPTION:
# some targets can be very very picky, so let's finesse the
# .config based upon any info we may have

compile_headers_tweak_config() {
	case ${CTARGET} in
	sh*)
		sed -i '/CONFIG_CPU_SH/d' .config || die
		echo "CONFIG_CPU_SH${CTARGET:2:1}=y" >> .config
		return 0;;
	esac

	# no changes, so lets do nothing
	return 1
}

# install functions

# @FUNCTION: install_universal
# @USAGE:
# @DESCRIPTION:
# Fix permissions in tarball

install_universal() {
	cd "${WORKDIR}"
	chown -R 0:0 * >& /dev/null
	chmod -R a+r-w+X,u+w *
	cd ${OLDPWD}
}

# @FUNCTION: install_headers
# @USAGE:
# @DESCRIPTION:
# Install headers

install_headers() {
	local ddir=$(kernel_header_destdir)

	env_setup_xmakeopts
	emake headers_install INSTALL_HDR_PATH="${ED}"/${ddir}/.. ${xmakeopts} || die

	# let other packages install some of these headers
	rm -rf "${ED}"/${ddir}/scsi || die #glibc/uclibc/etc...
}

# @FUNCTION: install_sources
# @USAGE:
# @DESCRIPTION:
# Install sources

install_sources() {
	local file

	cd "${S}"
	dodir /usr/src
	echo ">>> Copying sources ..."

	file="$(find ${WORKDIR} -iname "docs" -type d)"
	if [[ -n ${file} ]]; then
		for file in $(find ${file} -type f); do
			echo "${file//*docs\/}" >> "${S}"/patches.txt
			echo "===================================================" >> "${S}"/patches.txt
			cat ${file} >> "${S}"/patches.txt
			echo "===================================================" >> "${S}"/patches.txt
			echo "" >> "${S}"/patches.txt
		done
	fi

	mv "${WORKDIR}"/linux* "${ED}"/usr/src || die
}

# @FUNCTION: preinst_headers
# @USAGE:
# @DESCRIPTION:
# Headers preinst steps

preinst_headers() {
	local ddir=$(kernel_header_destdir)
	[[ -L ${EPREFIX}${ddir}/linux ]] && { rm "${EPREFIX}"${ddir}/linux || die; }
	[[ -L ${EPREFIX}${ddir}/asm ]] && { rm "${EPREFIX}"${ddir}/asm || die; }
}

# @FUNCTION: postinst_sources
# @USAGE:
# @DESCRIPTION:
# Sources post installation function.
# see inline comments

postinst_sources() {
	local MAKELINK=0

	# if we have USE=symlink, then force K_SYMLINK=1
	use symlink && K_SYMLINK=1

	# if we are to forcably symlink, delete it if it already exists first.
	if [[ ${K_SYMLINK} > 0 ]]; then
		[[ -h "${EROOT}"/usr/src/linux ]] && { rm "${EROOT}"/usr/src/linux || die; }
		MAKELINK=1
	fi

	# if the link doesnt exist, lets create it
	[[ ! -h "${EROOT}"/usr/src/linux ]] && MAKELINK=1

	if [[ ${MAKELINK} == 1 ]]; then
		ln -sf linux-${KV_FULL} "${EROOT}"/usr/src/linux || die
	fi

	# if K_EXTRAEINFO is set then lets display it now
	if [[ -n ${K_EXTRAEINFO} ]]; then
		echo ${K_EXTRAEINFO} | fmt |
		while read -s ELINE; do	einfo "${ELINE}"; done
	fi

	# if K_EXTRAELOG is set then lets display it now
	if [[ -n ${K_EXTRAELOG} ]]; then
		echo ${K_EXTRAELOG} | fmt |
		while read -s ELINE; do	elog "${ELINE}"; done
	fi

	# if K_EXTRAEWARN is set then lets display it now
	if [[ -n ${K_EXTRAEWARN} ]]; then
		echo ${K_EXTRAEWARN} | fmt |
		while read -s ELINE; do ewarn "${ELINE}"; done
	fi
}

# pkg_setup functions

# @FUNCTION: setup_headers
# @USAGE:
# @DESCRIPTION:
# Determine if ${PN} supports arch

setup_headers() {
	[[ -z ${H_SUPPORTEDARCH} ]] && H_SUPPORTEDARCH=${PN/-*/}
	for i in ${H_SUPPORTEDARCH}; do
		[[ $(tc-arch) == "${i}" ]] && H_ACCEPT_ARCH="yes"
	done

	if [[ ${H_ACCEPT_ARCH} != "yes" ]]; then
		echo
		eerror "This version of ${PN} does not support $(tc-arch)."
		eerror "Please merge the appropriate sources, in most cases"
		eerror "(but not all) this will be called $(tc-arch)-headers."
		die "Package unsupported for $(tc-arch)"
	fi
}

# @FUNCTION: getfilevar
# @USAGE: <variable> <configfile>
# @DESCRIPTION:
# pulled from linux-info

getfilevar() {
	local workingdir basefname basedname xarch=$(tc-arch-kernel)

	if [[ -z ${1} ]] && [[ ! -f ${2} ]]; then
		echo -e "\n"
		eerror "getfilevar requires 2 variables, with the second a valid file."
		eerror "   getfilevar <VARIABLE> <CONFIGFILE>"
	else
		workingdir=${PWD}
		basefname=$(basename ${2})
		basedname=$(dirname ${2})
		unset ARCH

		cd ${basedname}
		echo -e "include ${basefname}\ne:\n\t@echo \$(${1})" | \
			make ${BUILD_FIXES} -s -f - e 2>/dev/null
		cd ${workingdir}

		ARCH=${xarch}
	fi
}

# @FUNCTION: detect_arch
# @USAGE:
# @DESCRIPTION:
# This function sets ARCH_URI and ARCH_PATCH
# with the neccessary info for the arch sepecific compatibility
# patchsets.

detect_arch() {

	local ALL_ARCH LOOP_ARCH LOOP_ARCH_L COMPAT_URI i TC_ARCH_KERNEL

	# COMPAT_URI is the contents of ${ARCH}_URI
	# ARCH_URI is the URI for all the ${ARCH}_URI patches

	ARCH_URI=""
	ARCH_PATCH=""
	TC_ARCH_KERNEL=""
	ALL_ARCH="ALPHA AMD64 ARM HPPA IA64 M68K MIPS PPC PPC64 S390 SH SPARC X86"

	for LOOP_ARCH in ${ALL_ARCH}; do
		COMPAT_URI="${LOOP_ARCH}_URI"
		COMPAT_URI="${!COMPAT_URI}"

		declare -l LOOP_ARCH_L=${LOOP_ARCH}

		[[ -n ${COMPAT_URI} ]] && \
			ARCH_URI="${ARCH_URI} ${LOOP_ARCH_L}? ( ${COMPAT_URI} )"

		declare -u TC_ARCH_KERNEL=$(tc-arch-kernel)
		if [[ ${LOOP_ARCH} == ${TC_ARCH_KERNEL} ]]; then
			for i in ${COMPAT_URI}; do
				ARCH_PATCH="${ARCH_PATCH} ${DISTDIR}/${i/*\//}"
			done
		fi

	done
}

# @FUNCTION: headers___fix
# @USAGE:
# @DESCRIPTION:
# Voodoo to partially fix broken upstream headers.
# note: do not put inline/asm/volatile together (breaks "inline asm volatile")

headers___fix() {
	sed -i \
		-e '/^\#define.*_TYPES_H/{:loop n; bloop}' \
		-e 's:\<\([us]\(8\|16\|32\|64\)\)\>:__\1:g' \
		-e "s/\([[:space:]]\)inline\([[:space:](]\)/\1__inline__\2/g" \
		-e "s/\([[:space:]]\)asm\([[:space:](]\)/\1__asm__\2/g" \
		-e "s/\([[:space:]]\)volatile\([[:space:](]\)/\1__volatile__\2/g" \
		"$@"
}

# @FUNCTION: kernel-2_src_unpack
# @USAGE:
# @DESCRIPTION:
# unpack sources

kernel-2_src_unpack() {
	universal_unpack

	debug-print "Doing premake"

	# allow ebuilds to massage the source tree after patching but before
	# we run misc `make` functions below
	[[ $(type -t kernel-2_hook_premake) == "function" ]] && kernel-2_hook_premake

	debug-print "Doing unpack_set_extraversion"

	[[ -z ${K_NOSETEXTRAVERSION} ]] && unpack_set_extraversion
	unpack_fix_install_path

	# Setup xmakeopts and cd into sourcetree.
	env_setup_xmakeopts
	cd "${S}"
}

# @FUNCTION: kernel-2_src_compile
# @USAGE:
# @DESCRIPTION:
# conpile headers

kernel-2_src_compile() {
	cd "${S}"
	[[ ${ETYPE} == headers ]] && compile_headers
}

# @FUNCTION: kernel-2_src_test
# @USAGE:
# @DESCRIPTION:
# if you leave it to the default src_test, it will run make to
# find whether test/check targets are present; since "make test"
# actually produces a few support files, they are installed even
# though the package is binchecks-restricted.
#
# Avoid this altogether by making the function moot.
kernel-2_src_test() { :; }

# @FUNCTION: kernel-2_pkg_preinst
# @DESCRIPTION:
# if ETYPE = headers, call preinst_headers

kernel-2_pkg_preinst() {
	[[ ${ETYPE} == headers ]] && preinst_headers
}

# @FUNCTION: kernel-2_src_install
# @USAGE:
# @DESCRIPTION:
# Install headers or sources dependant on ETYPE

kernel-2_src_install() {
	install_universal
	[[ ${ETYPE} == headers ]] && install_headers
	[[ ${ETYPE} == sources ]] && install_sources
}

# @FUNCTION: kernel-2_pkg_postinst
# @USAGE:
# @DESCRIPTION:
# call postinst_sources for ETYPE = sources

kernel-2_pkg_postinst() {
	[[ ${ETYPE} == sources ]] && postinst_sources
}

# @FUNCTION: kernel-2_pkg_setup
# @USAGE:
# @DESCRIPTION:
# check for supported kernel version, die if ETYPE is unknown, call setup_headers
# if necessary

kernel-2_pkg_setup() {
	ABI="${KERNEL_ABI}"
	if [[ ${ETYPE} != sources ]] && [[ ${ETYPE} != headers ]]; then
		eerror "Unknown ETYPE=\"${ETYPE}\", must be \"sources\" or \"headers\""
		die "Unknown ETYPE=\"${ETYPE}\", must be \"sources\" or \"headers\""
	fi

	[[ ${ETYPE} == headers ]] && setup_headers
	[[ ${ETYPE} == sources ]] && echo ">>> Preparing to unpack ..."
}

# @FUNCTION: kernel-2_pkg_postrm
# @USAGE:
# @DESCRIPTION:
# Notify the user that after a depclean, there may be sources
# left behind that need to be manually cleaned

kernel-2_pkg_postrm() {
	# This warning only makes sense for kernel sources.
	[[ ${ETYPE} == headers ]] && return 0

	# If there isn't anything left behind, then don't complain.
	[[ -e "${EROOT}"/usr/src/linux-${KV_FULL} ]] || return 0
	echo
	ewarn "Note: Even though you have successfully unmerged "
	ewarn "your kernel package, directories in kernel source location: "
	ewarn "${EROOT}"/usr/src/linux-${KV_FULL}
	ewarn "with modified files will remain behind. By design, package managers"
	ewarn "will not remove these modified files and the directories they reside in."
	echo
}
