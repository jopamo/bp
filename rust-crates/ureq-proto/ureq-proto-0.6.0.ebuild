# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ureq-proto"
CRATE_VERSION="0.6.0"
CRATE_CHECKSUM="e994ba84b0bd1b1b0cf92878b7ef898a5c1760108fe7b6010327e274917a808c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="ureq support crate"
HOMEPAGE="https://github.com/algesten/ureq-proto"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"client"
	"default"
	"server"
)
