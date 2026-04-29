# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="libc"
CRATE_VERSION="0.2.155"
CRATE_CHECKSUM="97b3888a4aecf77e811145cadf6eef5901f4782c53886191b2f693f24761847c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Raw FFI bindings to platform libraries like libc."
HOMEPAGE="https://github.com/rust-lang/libc"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"align"
	"const-extern-fn"
	"default"
	"extra_traits"
	"rustc-dep-of-std"
	"std"
	"use_std"
)
