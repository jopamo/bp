# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="calendrical_calculations"
CRATE_VERSION="0.2.4"
CRATE_CHECKSUM="5abbd6eeda6885048d357edc66748eea6e0268e3dd11f326fff5bd248d779c26"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Calendrical calculations in Rust"
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"logging"
)
