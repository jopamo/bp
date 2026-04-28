# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="png"
CRATE_VERSION="0.17.13"
CRATE_CHECKSUM="06e4b0d3d1312775e782c86c91a111aa1f910cbb65e1337f9975b5f9a554b5e1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="PNG decoding and encoding library in pure Rust"
HOMEPAGE="https://github.com/image-rs/image-png"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"benchmarks"
	"unstable"
)
