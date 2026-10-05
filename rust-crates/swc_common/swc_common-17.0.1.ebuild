# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="swc_common"
CRATE_VERSION="17.0.1"
CRATE_CHECKSUM="259b675d633a26d24efe3802a9d88858c918e6e8f062d3222d3aa02d56a2cf4c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Common utilities for the swc project."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__plugin"
	"__plugin_mode"
	"__plugin_rt"
	"__rkyv"
	"concurrent"
	"debug"
	"default"
	"diagnostic-serde"
	"encoding-impl"
	"plugin-base"
	"plugin-mode"
	"plugin-rt"
	"plugin_transform_schema_v1"
	"plugin_transform_schema_vtest"
	"rkyv-impl"
	"shrink-to-fit"
	"sourcemap"
	"tty-emitter"
)
