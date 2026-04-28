# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bytesize"
CRATE_VERSION="2.3.1"
CRATE_CHECKSUM="6bd91ee7b2422bcb158d90ef4d14f75ef67f340943fc4149891dcce8f8b972a3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Semantic wrapper for byte count representations"
HOMEPAGE="https://github.com/bytesize-rs/bytesize"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"arbitrary"
	"default"
	"serde"
	"std"
)
