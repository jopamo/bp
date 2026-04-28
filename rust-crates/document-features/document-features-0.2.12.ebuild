# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="document-features"
CRATE_VERSION="0.2.12"
CRATE_CHECKSUM="d4b8a88685455ed29a21542a33abd9cb6510b6b129abadabdcef0f4c55bc8f61"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Extract documentation for the feature flags from comments in Cargo.toml"
HOMEPAGE="https://slint.rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"self-test"
)
