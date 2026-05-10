# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="iri-string"
CRATE_VERSION="0.7.8"
CRATE_CHECKSUM="dbc5ebe9c3a1a7a5127f920a418f7585e9e758e911d0466ed004f393b0e380b2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="IRI as string types"
HOMEPAGE="https://github.com/lo48576/iri-string"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
