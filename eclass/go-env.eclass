# Distributed under the terms of the GNU General Public License v2

# @ECLASS: go-env.eclass
# @MAINTAINER:
# 1g4 Project <1g4@example.org>
# @SUPPORTED_EAPIS: 7 8
# @BLURB: Environment setup for Go packages


if [[ -z ${_GO_ENV_ECLASS:-} ]]; then
_GO_ENV_ECLASS=1

inherit flag-o-matic toolchain-funcs

# @FUNCTION: go-env_set_compile_environment
# @DESCRIPTION:
# Set up CGO_* and GOARCH variables.
go-env_set_compile_environment() {
	tc-export CC CXX PKG_CONFIG

	export GOARCH="$(go-env_goarch)"
	export CGO_CFLAGS="${CGO_CFLAGS:-${CFLAGS-}}"
	export CGO_CPPFLAGS="${CGO_CPPFLAGS:-${CPPFLAGS-}}"
	export CGO_CXXFLAGS="${CGO_CXXFLAGS:-${CXXFLAGS-}}"
	export CGO_LDFLAGS="${CGO_LDFLAGS:-${LDFLAGS-}}"
}

# @FUNCTION: go-env_goarch
# @USAGE: [target]
# @DESCRIPTION:
# Convert a toolchain target to a GOARCH.
go-env_goarch() {
	local target arch cpu

	target=${1:-${CTARGET:-${CHOST:-}}}
	if [[ -n ${target} ]]; then
		arch=$(tc-arch "${target}")
	else
		arch=$(tc-arch)
	fi
	cpu=${target%%-*}

	case "${arch}" in
		x86)	echo 386;;
		loong)	echo loong64;;
		*)
			case "${cpu}" in
				aarch64*be)	echo arm64be;;
				arm64)		echo arm64;;
				arm*b*)		echo armbe;;
				mips64*l*)	echo mips64le;;
				mips*l*)	echo mipsle;;
				powerpc64le*)	echo ppc64le;;
				arm64|s390x)	echo "${cpu}";;
				mips64*|riscv64*|sparc64*) echo "${arch}64";;
				*)		echo "${arch}";;
			esac
			;;
	esac
}

fi
