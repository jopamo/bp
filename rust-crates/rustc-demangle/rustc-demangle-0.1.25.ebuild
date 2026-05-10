# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rustc-demangle"
CRATE_VERSION="0.1.25"
CRATE_CHECKSUM="989e6739f80c4ad5b13e0fd7fe89531180375b18520cc8c82080e4dc4035b84f"
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
