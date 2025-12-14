# Distributed under the terms of the GNU General Public License v2

# @ECLASS: go-env.eclass
# @MAINTAINER:
# 1g4 Project <1g4@example.org>
# @SUPPORTED_EAPIS: 7 8
# @BLURB: Environment setup for Go packages

if [[ -z ${_GO_ENV_ECLASS} ]]; then
_GO_ENV_ECLASS=1

inherit flag-o-matic toolchain-funcs

# @FUNCTION: go-env_set_compile_environment
# @DESCRIPTION:
# Set up CGO_* and GOARCH variables.
go-env_set_compile_environment() {
	tc-export CC CXX PKG_CONFIG

	export GOARCH="$(go-env_goarch)"
	export CGO_CFLAGS="${CGO_CFLAGS:-$CFLAGS}"
	export CGO_CPPFLAGS="${CGO_CPPFLAGS:-$CPPFLAGS}"
	export CGO_CXXFLAGS="${CGO_CXXFLAGS:-$CXXFLAGS}"
	export CGO_LDFLAGS="${CGO_LDFLAGS:-$LDFLAGS}"
}

# @FUNCTION: go-env_goarch
# @USAGE: [arch]
# @DESCRIPTION:
# Convert a toolchain arch to a GOARCH.
go-env_goarch() {
	local tc_arch=$(tc-arch $@)
	case "${tc_arch}" in
		x64-*)	echo amd64;;
		*)		echo "${tc_arch}";;
	esac
}

fi
