# Distributed under the terms of the GNU General Public License v2

# @ECLASS: rust-toolchain.eclass
# @SUPPORTED_EAPIS: 8
# @BLURB: helps map gentoo arches to rust ABIs

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

# Only used for URI helpers
: "${RUST_TOOLCHAIN_BASEURL:=https://static.rust-lang.org/dist/}"

# @FUNCTION: rust_abi
# Maps CHOST/CTARGET to a Rust ABI string (only amd64/arm64)
rust_abi() {
	local CTARGET=${1:-${CHOST}}
	case ${CTARGET%%-*} in
		aarch64*gnu)   echo aarch64-unknown-linux-gnu ;;
		aarch64*musl)  echo aarch64-unknown-linux-musl ;;
		x86_64*gnu)    echo x86_64-unknown-linux-gnu ;;
		x86_64*musl)   echo x86_64-unknown-linux-musl ;;
		*)             echo "${CTARGET}" ;;
	esac
}

# @FUNCTION: rust_arch_uri
# Output the URI for SRC_URI using $RUST_TOOLCHAIN_BASEURL and the Rust ABI
rust_arch_uri() {
	if [ -n "$3" ]; then
		echo "${RUST_TOOLCHAIN_BASEURL}${2}-${1}.tar.xz -> ${3}-${1}.tar.xz"
	else
		echo "${RUST_TOOLCHAIN_BASEURL}${2}-${1}.tar.xz"
		echo "verify-sig? ( ${RUST_TOOLCHAIN_BASEURL}${2}-${1}.tar.xz.asc )"
	fi
}

# @FUNCTION: rust_all_arch_uris
# Outputs SRC_URI blocks for amd64 and arm64 only
rust_all_arch_uris() {
	echo "
	abi_x86_64? (
		elibc_glibc? ( $(rust_arch_uri x86_64-unknown-linux-gnu  "$@") )
		elibc_musl?  ( $(rust_arch_uri x86_64-unknown-linux-musl "$@") )
	)
	arm64? (
		elibc_glibc? ( $(rust_arch_uri aarch64-unknown-linux-gnu  "$@") )
		elibc_musl?  ( $(rust_arch_uri aarch64-unknown-linux-musl "$@") )
	)
	"
}
