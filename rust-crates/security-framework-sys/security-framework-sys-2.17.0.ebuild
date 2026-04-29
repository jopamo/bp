# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="security-framework-sys"
CRATE_VERSION="2.17.0"
CRATE_CHECKSUM="6ce2691df843ecc5d231c0b14ece2acc3efb62c0a398c7e1d875f3983ce020e3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Apple \`Security.framework\` low-level FFI bindings"
HOMEPAGE="https://lib.rs/crates/security-framework-sys"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"OSX_10_10"
	"OSX_10_11"
	"OSX_10_12"
	"OSX_10_13"
	"OSX_10_14"
	"OSX_10_15"
	"OSX_10_9"
	"default"
	"macos-12"
)
