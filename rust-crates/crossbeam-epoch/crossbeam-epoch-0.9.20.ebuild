# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="crossbeam-epoch"
CRATE_VERSION="0.9.20"
CRATE_CHECKSUM="2d6914041f254d6e9176c01941b21115dcfb7089e55135a35411081bd106ef3f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Epoch-based garbage collection"
HOMEPAGE="https://github.com/crossbeam-rs/crossbeam/tree/master/crossbeam-epoch"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"loom"
	"nightly"
	"std"
)
