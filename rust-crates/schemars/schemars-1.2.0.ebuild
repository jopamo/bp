# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="schemars"
CRATE_VERSION="1.2.0"
CRATE_CHECKSUM="54e910108742c57a770f492731f99be216a52fadd361b06c8fb59d74ccc267d2"
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
