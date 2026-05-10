# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="dlv-list"
CRATE_VERSION="0.5.2"
CRATE_CHECKSUM="442039f5147480ba31067cb00ada1adae6892028e40e45fc5de7b7df6dcc1b5f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Semi-doubly linked list implemented using a vector"
HOMEPAGE="https://github.com/sgodwincs/dlv-list-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
