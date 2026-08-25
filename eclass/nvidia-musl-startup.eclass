# @ECLASS: nvidia-musl-startup.eclass
# @SUPPORTED_EAPIS: 8
# @BLURB: Link musl-native process roots to the NVIDIA compatibility startup closure.

if [[ -z ${_NVIDIA_MUSL_STARTUP_ECLASS:-} ]]; then
_NVIDIA_MUSL_STARTUP_ECLASS=1

inherit flag-o-matic toolchain-funcs

NVIDIA_MUSL_STARTUP_REQUIRED_USE='nvidia? ( elibc_musl? ( amd64 ) )'
NVIDIA_MUSL_STARTUP_DEPEND='
	nvidia? (
		elibc_musl? (
			bin/nvidia-drivers[X]
			lib-core/musl-bsd
		)
	)
'
NVIDIA_MUSL_STARTUP_BDEPEND='nvidia? ( elibc_musl? ( app-dev/pkgconf ) )'

# @FUNCTION: nvidia_musl_startup_configure
# @DESCRIPTION:
# Force the qualified musl-bsd host/facade closure and NVIDIA initial-exec TLS
# anchor into the initial DT_NEEDED graph. Call before the package build system
# consumes LDFLAGS.
nvidia_musl_startup_configure() {
	use nvidia && use elibc_musl || return 0

	local host_flags nvidia_flags
	local -a startup_flags
	host_flags=$(pkg-config --libs musl-bsd-glibc-startup) ||
		die "cannot resolve the qualified musl-bsd startup interface"
	nvidia_flags=$(pkg-config --libs nvidia-musl-startup) ||
		die "cannot resolve the NVIDIA musl startup interface"

	# Keep the host/facades ahead of the vendor TLS anchor. Both interfaces
	# scope --no-as-needed themselves, so no ambient linker policy is weakened.
	read -r -a startup_flags <<< "${host_flags} ${nvidia_flags}"
	append-ldflags "${startup_flags[@]}"
}

# @FUNCTION: nvidia_musl_startup_verify
# @USAGE: /absolute/installed/executable
# @DESCRIPTION:
# Fail closed unless the installed process root records the complete startup
# closure directly and keeps the private facade directory in RUNPATH.
nvidia_musl_startup_verify() {
	use nvidia && use elibc_musl || return 0
	[[ $# == 1 && ${1} == /* ]] ||
		die "nvidia_musl_startup_verify requires one absolute installed path"

	local binary="${ED}${1}"
	local dynamic needed required host_index libc_index

	[[ -x ${binary} ]] || die "missing NVIDIA process root: ${1}"
	dynamic=$("$(tc-getREADELF)" -dW "${binary}") ||
		die "cannot inspect NVIDIA process root: ${1}"
	needed=$(sed -n 's/.*(NEEDED).*\[\(.*\)\].*/\1/p' <<< "${dynamic}")

	for required in \
		libmusl-bsd-glibc-host.so.2 \
		libc.so.6 \
		libdl.so.2 \
		libm.so.6 \
		libpthread.so.0 \
		libresolv.so.2 \
		librt.so.1 \
		libutil.so.1 \
		libnvidia-musl-startup.so.1; do
		grep -Fx "${required}" <<< "${needed}" >/dev/null ||
			die "${1} startup closure is missing ${required}"
	done

	host_index=$(grep -Fnx 'libmusl-bsd-glibc-host.so.2' <<< "${needed}" |
		cut -d: -f1)
	libc_index=$(grep -Fnx 'libc.so' <<< "${needed}" | cut -d: -f1)
	[[ -n ${host_index} && -n ${libc_index} && ${host_index} -lt ${libc_index} ]] ||
		die "musl-bsd host must precede musl libc in ${1}"

	grep -F '/usr/lib/musl-bsd/glibc' <<< "${dynamic}" >/dev/null ||
		die "${1} startup closure is missing the private facade RUNPATH"
}

fi
