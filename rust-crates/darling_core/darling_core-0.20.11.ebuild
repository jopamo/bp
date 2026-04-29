# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="darling_core"
CRATE_VERSION="0.20.11"
CRATE_CHECKSUM="0d00b9596d185e565c2207a0b01f8bd1a135483d02d9b7b0a54b11da8d53412e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helper crate for proc-macro library for reading attributes into structs when implementing custom derives. Use https://crates.io/crates/darling in your code."
HOMEPAGE="https://github.com/TedDriggs/darling"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"diagnostics"
	"suggestions"
)
