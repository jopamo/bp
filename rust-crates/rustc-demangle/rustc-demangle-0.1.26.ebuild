# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustc-demangle"
CRATE_VERSION="0.1.26"
CRATE_CHECKSUM="56f7d92ca342cea22a06f2121d944b4fd82af56988c270852495420f961d4ace"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust compiler symbol demangling."
HOMEPAGE="https://github.com/rust-lang/rustc-demangle"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"compiler_builtins"
	"rustc-dep-of-std"
	"std"
)
