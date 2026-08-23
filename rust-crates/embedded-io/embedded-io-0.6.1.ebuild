# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="embedded-io"
CRATE_VERSION="0.6.1"
CRATE_CHECKSUM="edd0f118536f44f5ccd48bcb8b111bdc3de888b58c74639dfb034a357d0f206d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Embedded IO traits"
HOMEPAGE="https://github.com/rust-embedded/embedded-hal"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"defmt-03"
	"std"
)
