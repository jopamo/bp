# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="proc-macro2"
CRATE_VERSION="1.0.107"
CRATE_CHECKSUM="985e7ec9bb745e6ce6535b544d84d6cd6f7ad8bd711c398938ae983b91a766d9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A substitute implementation of the compiler's \`proc_macro\` API to decouple token-based libraries from the procedural macro use case."
HOMEPAGE="https://github.com/dtolnay/proc-macro2"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
	"proc-macro"
	"span-locations"
)
