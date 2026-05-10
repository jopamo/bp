# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="gif"
CRATE_VERSION="0.12.0"
CRATE_CHECKSUM="80792593675e051cf94a4b111980da2ba60d4a83e43e0048c5693baab3977045"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="GIF de- and encoder"
HOMEPAGE="https://github.com/image-rs/image-gif"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"raii_no_panic"
	"std"
)
