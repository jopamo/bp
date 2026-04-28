# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="prost-build"
CRATE_VERSION="0.13.3"
CRATE_CHECKSUM="0c1318b19085f08681016926435853bbf7858f9c082d0999b80550ff5d9abe15"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generate Prost annotated Rust types from Protocol Buffers files."
HOMEPAGE="https://github.com/tokio-rs/prost"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cleanup-markdown"
	"default"
	"format"
)
