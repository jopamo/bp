# Distributed under the terms of the GNU General Public License v2

inherit flag-o-matic toolchain-funcs

# @ECLASS: cuda.eclass
# @MAINTAINER:
# Justin Lecher <jlec@gentoo.org>
# @BLURB: Common functions for cuda packages
# @DESCRIPTION:
# This eclass contains functions to be used with cuda package. Currently it is
# setting and/or sanitizing NVCCFLAGS, the compiler flags for nvcc. This is
# automatically done and exported in src_prepare() or manually by calling
# cuda_sanatize.
# @EXAMPLE:
# inherit cuda

if [[ -z ${_CUDA_ECLASS} ]]; then

# @ECLASS-VARIABLE: NVCCFLAGS
# @DESCRIPTION:
# nvcc compiler flags (see nvcc --help), which should be used like
# CFLAGS for c compiler
: ${NVCCFLAGS:=-O2}

# @ECLASS-VARIABLE: CUDA_VERBOSE
# @DESCRIPTION:
# Being verbose during compilation to see underlying commands
: ${CUDA_VERBOSE:=true}

# @FUNCTION: cuda_sanitize
# @DESCRIPTION:
# Correct NVCCFLAGS by adding the necessary reference to gcc bindir and
# passing CXXFLAGS to underlying compiler without disturbing nvcc.
cuda_sanitize() {
	debug-print-function ${FUNCNAME} "$@"

	local rawldflags=$(raw-ldflags)
	# Be verbose if wanted
	[[ "${CUDA_VERBOSE}" == true ]] && NVCCFLAGS+=" -v"

	# Tell nvcc which flags should be used for underlying C compiler
	NVCCFLAGS+=" --compiler-options \"${CXXFLAGS}\" --linker-options \"${rawldflags// /,}\""

	debug-print "Using ${NVCCFLAGS} for cuda"
	export NVCCFLAGS
}

# @FUNCTION: cuda_pkg_setup
# @DESCRIPTION:
# Call cuda_src_prepare for EAPIs not supporting src_prepare
cuda_pkg_setup() {
	debug-print-function ${FUNCNAME} "$@"

	cuda_src_prepare
}

# @FUNCTION: cuda_src_prepare
# @DESCRIPTION:
# Sanitise and export NVCCFLAGS by default
cuda_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	cuda_sanitize
}

case "${EAPI:-0}" in
	0|1)
		EXPORT_FUNCTIONS pkg_setup ;;
	2|3|4|5|6|7)
		EXPORT_FUNCTIONS src_prepare ;;
	*) die "EAPI=${EAPI} is not supported" ;;
esac

_CUDA_ECLASS=1
fi
