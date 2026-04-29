# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="yoke"
CRATE_VERSION="0.7.4"
CRATE_CHECKSUM="6c5b1314b079b0930c31e3af543d8ee1757b1951ae1e1565ec704403a7240ca5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Abstraction allowing borrowed data to be carried along with the backing data it borrows from"
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"derive"
	"serde"
	"zerofrom"
)
