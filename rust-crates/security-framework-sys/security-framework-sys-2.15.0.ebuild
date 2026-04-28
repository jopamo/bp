# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="security-framework-sys"
CRATE_VERSION="2.15.0"
CRATE_CHECKSUM="cc1f0cbffaac4852523ce30d8bd3c5cdc873501d96ff467ca09b6767bb8cd5c0"
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
)
