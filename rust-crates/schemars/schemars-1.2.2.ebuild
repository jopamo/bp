# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="schemars"
CRATE_VERSION="1.2.2"
CRATE_CHECKSUM="687274d293b6cdc6e73e0fee520bf2049650090d7164f87672d212a3c530cf4a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generate JSON Schemas from Rust code"
HOMEPAGE="https://graham.cool/schemars/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"_ui_test"
	"default"
	"derive"
	"preserve_order"
	"raw_value"
	"std"
)
