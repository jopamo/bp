# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="crossbeam-utils"
CRATE_VERSION="0.8.23"
CRATE_CHECKSUM="a31eee39dddec8330830986fcd7625edb5a24ec90ea038215273bbc3adb08ac6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Utilities for concurrent programming"
HOMEPAGE="https://github.com/crossbeam-rs/crossbeam/tree/master/crossbeam-utils"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
	"std"
)
