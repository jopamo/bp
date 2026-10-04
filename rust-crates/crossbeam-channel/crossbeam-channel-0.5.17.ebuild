# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="crossbeam-channel"
CRATE_VERSION="0.5.17"
CRATE_CHECKSUM="98b0cc327b5bc766e7fda9c9260cc0fa81b43a8e240440422dff70788e3f9ef1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Multi-producer multi-consumer channels for message passing"
HOMEPAGE="https://github.com/crossbeam-rs/crossbeam/tree/master/crossbeam-channel"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
