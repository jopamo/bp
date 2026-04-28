# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="document-features"
CRATE_VERSION="0.2.10"
CRATE_CHECKSUM="cb6969eaabd2421f8a2775cfd2471a2b634372b4a25d41e3bd647b79912850a0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Extract documentation for the feature flags from comments in Cargo.toml"
HOMEPAGE="https://slint.rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"self-test"
)
