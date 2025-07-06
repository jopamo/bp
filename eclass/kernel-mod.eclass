# Distributed under the terms of the GNU General Public License v2

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_LINUX_MOD_R1_ECLASS} ]]; then
_LINUX_MOD_R1_ECLASS=1

inherit edo linux-info multiprocessing toolchain-funcs

IUSE="modules-compress modules-sign +strip initramfs ${MODULES_OPTIONAL_IUSE}"

RDEPEND="
	app-core/kmod[tools]
"

DEPEND="virtual/linux-sources"
BDEPEND="
	app-dev/dwarves
	app-core/kmod[tools]
	modules-sign? (
		virtual/ssl
		app-dev/pkgconf
	)
"

IDEPEND="app-core/kmod[tools]"


: "${MODULES_SIGN_CERT:=certs/signing_key.x509}"

declare -gA _MODULES_GLOBAL=()
declare -gA _MODULES_INSTALL=()

kernel-mod_pkg_setup() {
	debug-print-function ${FUNCNAME} "$@"
	_MODULES_GLOBAL[ran:pkg_setup]=1
	_modules_check_function ${#} 0 0 || return 0

	[[ ${MERGE_TYPE} != binary ]] || return 0

	_modules_check_migration
	_modules_prepare_kernel
	_modules_prepare_sign
	_modules_prepare_toolchain
	_modules_set_makeargs
	_modules_sanity_gccplugins
}

kernel-mod_src_compile() {
	debug-print-function ${FUNCNAME} "$@"
	_modules_check_function ${#} 0 0 || return 0

	[[ ${modlist@a} == *a* && ${#modlist[@]} -gt 0 ]] || die "${FUNCNAME[0]} was called without a 'modlist' array"
	_modules_sanity_kernelbuilt

	local -a emakeargs=( "${MODULES_MAKEARGS[@]}" )
	[[ ${modargs@a} == *a* ]] && emakeargs+=( "${modargs[@]}" )

	local -A built=()
	local build mod name target
	for mod in "${modlist[@]}"; do
		name=${mod%%=*}
		[[ -n ${name} && ${name} != *:* ]] || die "invalid mod entry '${mod}'"
		mod=${mod#"${name}"}
		IFS=: read -ra mod <<<"${mod#=}"
		[[ ${#mod[@]} -le 4 ]] || die "too many ':' in ${name}'s modlist"
		[[ ${mod[1]:=${PWD}} != /* ]] && mod[1]=${PWD}/${mod[1]}
		[[ ${mod[2]:=${mod[1]}} != /* ]] && mod[2]=${PWD}/${mod[2]}
		_MODULES_INSTALL[${mod[2]}/${name}.ko]=${mod[0]:-extra}

		pushd "${mod[1]}" >/dev/null || die

		if [[ -z ${mod[3]} ]]; then
			for target in module{s,} "${name}".ko default all; do
				nonfatal emake "${emakeargs[@]}" -q "${target}" &>/dev/null
				if [[ $? -eq 1 ]]; then
					mod[3]=${target}
					break
				fi
			done
		fi

		build=
		for target in ${mod[3]:-&}; do
			if ! has "${target}" ${built[${mod[1]}]}; then
				build=1
				built[${mod[1]}]+=" ${target} "
			fi
		done

		if [[ ${build} ]]; then
			einfo "Building ${name} module in ${mod[1]} ..."
			emake "${emakeargs[@]}" ${mod[3]}
		else
			einfo "Building ${name} module in ${mod[1]} ... already done."
		fi

		popd >/dev/null || die
	done
}

kernel-mod_src_install() {
	debug-print-function ${FUNCNAME} "$@"
	_modules_check_function ${#} 0 0 || return 0

	(( ${#_MODULES_INSTALL[@]} )) ||
		die "${FUNCNAME[0]} was called without running kernel-mod_src_compile"

	(
		for mod in "${!_MODULES_INSTALL[@]}"; do
			linux_moduleinto "${_MODULES_INSTALL[${mod}]}"
			linux_domodule "${mod}"
		done
	)

	modules_post_process
}

kernel-mod_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"
	_modules_check_function ${#} 0 0 || return 0

	# Update module dependencies first
	_modules_update_depmod

	if use initramfs; then
		if type -P dracut &>/dev/null; then
			einfo "Rebuilding initramfs for kernel ${KV_FULL} with dracut ..."
			nonfatal edob dracut --force --kver "${KV_FULL}" \
				"/boot/initramfs-${KV_FULL}.img" ||
				ewarn "dracut failed to rebuild the initramfs."
		else
			ewarn "USE=initramfs is set but dracut is not available. Skipping initramfs rebuild."
		fi
	fi

	[[ -v _MODULES_GLOBAL[ran:post_process] ]] || \
		eqawarn "QA Notice: neither kernel-mod_src_install nor modules_post_process were used"
}

linux_domodule() {
	debug-print-function ${FUNCNAME} "$@"
	_modules_check_function ${#} 1 '' "<module>..." || return 0
	(
		insinto "/lib/modules/${KV_FULL}/${_MODULES_GLOBAL[moduleinto]:-extra}"
		doins "$@"
	)
}

linux_moduleinto() {
	debug-print-function ${FUNCNAME} "$@"
	_modules_check_function ${#} 1 1 "<install-dir>" || return 0
	_MODULES_GLOBAL[moduleinto]=$1
}

modules_post_process() {
	debug-print-function ${FUNCNAME} "$@"
	_modules_check_function ${#} 0 1 '[<path>]' || return 0
	[[ ${EBUILD_PHASE} == install ]] || die "${FUNCNAME[0]} can only be called in the src_install phase"

	local path=${ED}${1-/lib/modules/${KV_FULL}}
	local -a mods
	[[ -d ${path} ]] && mapfile -td '' mods < <(find "${path}" -type f -name '*.ko' -print0 || die)
	(( ${#mods[@]} )) || die "${FUNCNAME[0]} was called with no installed modules under ${path}"

	_modules_process_dracut.conf.d "${mods[@]##*/}"
	_modules_process_strip "${mods[@]}"
	_modules_process_sign "${mods[@]}"
	_modules_sanity_modversion "${mods[@]}"
	_modules_process_compress "${mods[@]}"
	_MODULES_GLOBAL[ran:post_process]=1
}

_modules_check_function() {
	[[ -z ${MODULES_OPTIONAL_IUSE} ]] || use "${MODULES_OPTIONAL_IUSE#+}" || return 1
	[[ ${#} == 0 || ${1} -ge ${2} && ( ! ${3} || ${1} -le ${3} ) ]] || die "Usage: ${FUNCNAME[1]} ${4-(no arguments)}"
	[[ -v _MODULES_GLOBAL[ran:pkg_setup] ]] || \
		die "${FUNCNAME[1]} was called without running kernel-mod_pkg_setup"
}

_modules_check_migration() {
	[[ -z ${MODULES_OPTIONAL_USE} ]] || \
		die "MODULES_OPTIONAL_USE is obsolete, see the new variables in kernel-mod eclass"
	[[ -z ${MODULES_OPTIONAL_USE_IUSE_DEFAULT} ]] || die "MODULES_OPTIONAL_USE_IUSE_DEFAULT is obsolete"
	[[ -z ${BUILD_PARAMS} ]] || die "BUILD_PARAMS is obsolete"
	[[ -z ${BUILD_TARGETS} ]] || die "BUILD_TARGETS is obsolete"
	[[ -z ${MODULE_NAMES} ]] || die "MODULE_NAMES is obsolete"
	[[ -z ${!MODULESD_*} ]] || \
		die "MODULESD_* variables are no longer supported, replace with a handcrafted .conf if needed"
}

_modules_prepare_kernel() {
	SKIP_KERNEL_BINPKG_ENV_RESET=1
	get_version
	[[ -n ${KV_FULL} ]] || die "kernel sources are required to build kernel modules"
	require_configured_kernel
	_modules_sanity_kernelbuilt
	_modules_sanity_kernelversion

	local CONFIG_CHECK="${CONFIG_CHECK} MODULES"
	if [[ $(linux_chkconfig_string UNUSED_KSYMS_WHITELIST) == \"+(?)\" ]]; then
		CONFIG_CHECK+=" ~!TRIM_UNUSED_KSYMS"
	else
		CONFIG_CHECK+=" !TRIM_UNUSED_KSYMS"
	fi
	linux-info_pkg_setup
}

_modules_prepare_sign() {
	use modules-sign || return 0
	_modules_sign_die() {
		eerror "USE=modules-sign requires additional configuration."
		die "USE=modules-sign is set but $*"
	}
	linux_chkconfig_present MODULE_SIG || _modules_sign_die "CONFIG_MODULE_SIG is not set"

	if [[ -z ${MODULES_SIGN_HASH} ]]; then
		: "$(linux_chkconfig_string MODULE_SIG_HASH)"
		MODULES_SIGN_HASH=${_//\"}
		[[ -n ${MODULES_SIGN_HASH} ]] || _modules_sign_die "CONFIG_MODULE_SIG_HASH is not set"
	fi

	if [[ -z ${MODULES_SIGN_KEY} ]]; then
		: "$(linux_chkconfig_string MODULE_SIG_KEY)"
		MODULES_SIGN_KEY=${_//\"}
		[[ -n ${MODULES_SIGN_KEY} ]] || _modules_sign_die "CONFIG_MODULE_SIG_KEY is not set"
	fi

	[[ ${MODULES_SIGN_KEY} != @(/|pkcs11:)* ]] && MODULES_SIGN_KEY=${KV_OUT_DIR}/${MODULES_SIGN_KEY}
	[[ ${MODULES_SIGN_CERT} != /* ]] && MODULES_SIGN_CERT=${KV_OUT_DIR}/${MODULES_SIGN_CERT}
	[[ ${MODULES_SIGN_KEY} == pkcs11:* || -f ${MODULES_SIGN_KEY} ]] || \
		_modules_sign_die "the private key '${MODULES_SIGN_KEY}' was not found"
	[[ -f ${MODULES_SIGN_CERT} ]] || _modules_sign_die "the public key certificate '${MODULES_SIGN_CERT}' was not found"
}

_modules_prepare_toolchain() {
	[[ -z ${KERNEL_CHOST} ]] && linux_chkconfig_present 64BIT && \
		case ${CHOST} in
			hppa2.0-*) KERNEL_CHOST=${CHOST/2.0/64};;
		esac
	: "${KERNEL_CHOST:=${CHOST}}"
	einfo "Preparing ${KERNEL_CHOST} toolchain for kernel modules ..."
	_modules_tc_best() {
		[[ -z ${!1} ]] && read -r ${1} < <(type -P -- "${@:2}")
	}

	local gccv clangv tool
	if linux_chkconfig_present CC_IS_GCC; then
		gccv=$(linux_chkconfig_string GCC_VERSION)
		gccv=${gccv::2}
		_modules_tc_best KERNEL_CC {"${KERNEL_CHOST}-",}gcc{"-${gccv}",}
		_modules_tc_best KERNEL_CXX {"${KERNEL_CHOST}-",}g++{"-${gccv}",}
		for tool in AR NM OBJCOPY OBJDUMP READELF STRIP; do
			_modules_tc_best KERNEL_${tool} {"${KERNEL_CHOST}-",}{gcc-,}${tool,,}
		done
	elif linux_chkconfig_present CC_IS_CLANG; then
		clangv=$(linux_chkconfig_string CLANG_VERSION)
		clangv=${clangv::2}
		_modules_tc_best KERNEL_CC {"${BROOT}/usr/lib/llvm/${clangv}/bin/",}{"${KERNEL_CHOST}-",}clang{"-${clangv}",}
		_modules_tc_best KERNEL_CXX {"${BROOT}/usr/lib/llvm/${clangv}/bin/",}{"${KERNEL_CHOST}-",}clang++{"-${clangv}",}
		for tool in AR NM OBJCOPY OBJDUMP READELF STRIP; do
			_modules_tc_best KERNEL_${tool} \
				{"${BROOT}/usr/lib/llvm/${clangv}/bin/",}{"${KERNEL_CHOST}-",}{llvm-,}${tool,,}
		done
	fi

	if linux_chkconfig_present LD_IS_BFD; then
		_modules_tc_best KERNEL_LD {"${KERNEL_CHOST}-",}ld.bfd
	elif linux_chkconfig_present LD_IS_LLD; then
		_modules_tc_best KERNEL_LD \
			{${clangv+"${BROOT}/usr/lib/llvm/${clangv}/bin/"},}{"${KERNEL_CHOST}-",}ld.lld
	fi

	local CHOST=${KERNEL_CHOST}
	: "${KERNEL_CC:=$(tc-getCC)}"
	: "${KERNEL_CXX:=$(tc-getCXX)}"
	: "${KERNEL_LD:=$(tc-getLD)}"
	: "${KERNEL_AR:=$(tc-getAR)}"
	: "${KERNEL_NM:=$(tc-getNM)}"
	: "${KERNEL_OBJCOPY:=$(tc-getOBJCOPY)}"
	: "${KERNEL_OBJDUMP:=$(tc-getOBJDUMP)}"
	: "${KERNEL_READELF:=$(tc-getREADELF)}"
	: "${KERNEL_STRIP:=$(tc-getSTRIP)}"

	local CC=${KERNEL_CC} CPP="${KERNEL_CC} -E" LD=${KERNEL_LD}
	if linux_chkconfig_present LTO_CLANG_THIN && tc-ld-is-lld; then
		KERNEL_LD=${T}/kernel-mod_ld.lld
		printf '#!/usr/bin/env sh\nexec %q "${@}" --thinlto-cache-dir=\n' \
			"${LD}" > "${KERNEL_LD}" || die
		chmod +x -- "${KERNEL_LD}" || die
	fi

	local warn
	if [[ -v gccv ]]; then
		if ! tc-is-gcc; then
			warn="gcc-${gccv} but '${KERNEL_CC}' is not gcc"
		elif [[ $(gcc-major-version) -ne "${gccv}" ]]; then
			warn="gcc-${gccv} but '${KERNEL_CC}' is gcc-$(gcc-major-version)"
		fi
	elif [[ -v clangv ]]; then
		if ! tc-is-clang; then
			warn="clang-${clangv} but '${KERNEL_CC}' is not clang"
		elif [[ $(clang-major-version) -ne "${clangv}" ]]; then
			warn="clang-${clangv} but '${KERNEL_CC}' is clang-$(clang-major-version)"
		fi
	fi

	if [[ -v warn ]]; then
		ewarn
		ewarn "Warning: kernel ${KV_FULL} is built with ${warn}"
		ewarn "Possible mismatch."
		ewarn
	fi

	einfo \
		"Toolchain picked for kernel modules:" \
		"'${KERNEL_CC}' '${KERNEL_CXX}' '${KERNEL_LD}' '${KERNEL_AR}'" \
		"'${KERNEL_NM}' '${KERNEL_OBJCOPY}' '${KERNEL_OBJDUMP}'" \
		"'${KERNEL_READELF}' '${KERNEL_STRIP}'"
}

_modules_process_compress() {
	use modules-compress || return 0
	local -a compress

	if linux_chkconfig_present MODULE_COMPRESS_XZ; then
		compress=( xz -q --memlimit-compress=50% --threads="$(makeopts_jobs)" --check=crc32 --lzma2=dict=1MiB )
	elif linux_chkconfig_present MODULE_COMPRESS_GZIP; then
		if type -P pigz &>/dev/null; then
			compress=( pigz -p"$(makeopts_jobs)" )
		else
			compress=( gzip )
		fi
	elif linux_chkconfig_present MODULE_COMPRESS_ZSTD; then
		compress=( zstd -qT"$(makeopts_jobs)" --rm )
	else
		die "USE=modules-compress enabled but no MODULE_COMPRESS* configured"
	fi

	einfo "Compressing modules ..."
	edob "${compress[@]}" -- "$@"
}

_modules_process_dracut.conf.d() {
	(
		insinto /usr/lib/dracut/dracut.conf.d
		newins - 10-${PN}.conf <<<"_drivers+=\" ${*%.ko} \""
	)
}

_modules_process_sign() {
	use modules-sign || return 0
	local sign=

	if [[ -f ${KV_DIR}/scripts/sign-file.c ]]; then
		sign=${T}/kernel-mod_sign-file
		(
			einfo "Compiling sign-file ..."
			tc-export_build_env
			nonfatal edob \
				"$(tc-getBUILD_CC)" \
				${BUILD_CFLAGS} \
				${BUILD_CPPFLAGS} \
				$($(tc-getBUILD_PKG_CONFIG) --cflags libcrypto) \
				${BUILD_LDFLAGS} \
				-o "${sign}" \
				"${KV_DIR}/scripts/sign-file.c" \
				$($(tc-getBUILD_PKG_CONFIG) --libs libcrypto || echo -lcrypto)
		) || sign=
	fi

	if [[ -z ${sign} ]]; then
		if [[ -x ${KV_OUT_DIR}/scripts/sign-file ]]; then
			sign=${KV_OUT_DIR}/scripts/sign-file
		elif [[ -x ${KV_DIR}/scripts/sign-file ]]; then
			sign=${KV_DIR}/scripts/sign-file
		else
			die "USE=modules-sign is set but '${KV_DIR}/scripts/sign-file.c' is not usable"
		fi
	fi

	einfo "Signing modules ..."
	[[ ${MODULES_SIGN_KEY} == pkcs11:* || -r ${MODULES_SIGN_KEY} ]] || \
		die "USE=modules-sign is set but lacking read access to '${MODULES_SIGN_KEY}'"

	local mod
	for mod; do
		edob "${sign}" "${MODULES_SIGN_HASH}" "${MODULES_SIGN_KEY}" "${MODULES_SIGN_CERT}" "${mod}"
	done

	unset KBUILD_SIGN_PIN
}

_modules_process_strip() {
	dostrip -x "${@#"${ED}"}"
	if use strip; then
		einfo "Stripping modules ..."
		edob "${KERNEL_STRIP}" --strip-unneeded -- "$@"
	fi
}

_modules_sanity_gccplugins() {
	linux_chkconfig_present GCC_PLUGINS || return 0
	local tmp=${T}/kernel-mod_gccplugins
	mkdir -p -- "${tmp}" || die
	echo "obj-m += test.o" > "${tmp}/Kbuild" || die
	:> "${tmp}/test.c" || die

	local output=$(
		cd -- "${KV_OUT_DIR}" && \
			LC_ALL=C nonfatal emake "${MODULES_MAKEARGS[@]}" M="${tmp}" \
			2>&1 >/dev/null
	)

	if [[ ${output} == *"error: incompatible gcc/plugin version"* ]]; then
		eerror "GCC_PLUGINS mismatch"
		die "kernel ${KV_FULL} needs to be rebuilt"
	fi
}

_modules_sanity_kernelbuilt() {
	local symvers=${KV_OUT_DIR}/Module.symvers
	if [[ ! -f ${symvers} ]]; then
		eerror "'${symvers}' was not found, kernel tree not built."
		die "built kernel sources are required"
	fi

	if [[ ! -r ${symvers} ]]; then
		eerror "'${symvers}' exists but is not readable by user id(${EUID})."
		die "no read access to generated kernel files"
	fi
}

_modules_sanity_kernelversion() {
	local kv=${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}
	if [[ -n ${MODULES_KERNEL_MIN} ]] && ver_test "${kv}" -lt "${MODULES_KERNEL_MIN}"; then
		eerror "${P} requires a kernel >=${MODULES_KERNEL_MIN}, but current is ${KV_FULL}"
		die "kernel ${KV_FULL} is too old"
	fi

	if [[ -n ${MODULES_KERNEL_MAX} ]]; then
		: "${MODULES_KERNEL_MAX//[^.]/}"
		local -i count=${#_}
		if ver_test "$(ver_cut 1-$((count+1)) "${kv}")" -gt "${MODULES_KERNEL_MAX}"; then
			ewarn " *** WARNING *** kernel ${KV_FULL} is untested or known to break"
		fi
	fi
}

_modules_sanity_modversion() {
	local mod ver
	for mod; do
		read -rd ' ' ver < <(LC_ALL=C modinfo -F vermagic -- "${mod}" || die "modinfo failed for '${mod}'")
		[[ -n ${ver} ]] || die "modinfo found no kernel version in '${mod}'"

		if [[ ${ver} != "${KV_FULL}" ]]; then
			eerror "Module built for '${ver}' not matching '${KV_FULL}'"
			die "Module/source mismatch in '${mod}'"
		fi
	done
}

_modules_set_makeargs() {
	MODULES_MAKEARGS=(
		ARCH="$(tc-arch-kernel)"
		V=1
		KBUILD_VERBOSE=1
		CONFIG_WERROR=
		CONFIG_MODULE_{SIG_ALL,COMPRESS_{ALL,GZIP,XZ,ZSTD}}=
		DEPMOD=true
		STRIP=true
	)

	if [[ ! ${MODULES_I_WANT_FULL_CONTROL} ]]; then
		MODULES_MAKEARGS+=(
			CROSS_COMPILE="${KERNEL_CHOST}-"
			HOSTCC="$(tc-getBUILD_CC)"
			HOSTCXX="$(tc-getBUILD_CXX)"
			HOSTCFLAGS="$(tc-export_build_env; echo "${BUILD_CFLAGS}")"
			HOSTCXXFLAGS="$(tc-export_build_env; echo "${BUILD_CXXFLAGS}")"
			HOSTLDFLAGS="$(tc-export_build_env; echo "${BUILD_LDFLAGS}")"
			HOSTPKG_CONFIG="$(tc-getBUILD_PKG_CONFIG)"
			CC="${KERNEL_CC}"
			CXX="${KERNEL_CXX}"
			LD="${KERNEL_LD}"
			AR="${KERNEL_AR}"
			NM="${KERNEL_NM}"
			OBJCOPY="${KERNEL_OBJCOPY}"
			OBJDUMP="${KERNEL_OBJDUMP}"
			READELF="${KERNEL_READELF}"
		)
	fi

	eval "MODULES_MAKEARGS+=( ${MODULES_EXTRA_EMAKE} )" || die
}

_modules_update_depmod() {
	local map=${EROOT}/lib/modules/${KV_FULL}/build/System.map
	if [[ ! -f ${map} ]]; then
		map=${KV_OUT_DIR}/System.map
		[[ ! -f ${map} ]] && map=${EROOT}/boot/System.map-${KV_FULL}
	fi

	einfo "Updating module dependencies for kernel ${KV_FULL} ..."
	if [[ -f ${map} ]]; then
		local depmodargs=( -ae -F "${map}" "${KV_FULL}" )
		[[ ${EROOT} ]] && depmodargs+=(
			-b "${EROOT}"
			--config="${EROOT}"/{etc,run,{usr/{local/,},}lib}/depmod.d
		)
		nonfatal edob depmod "${depmodargs[@]}" && return 0
	else
		eerror "System.map for kernel ${KV_FULL} was not found."
	fi

	eerror "Some modules may not load without manual depmod."
}

EXPORT_FUNCTIONS pkg_setup src_compile src_install pkg_postinst

fi
