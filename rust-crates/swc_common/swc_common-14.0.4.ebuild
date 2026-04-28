# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_common"
CRATE_VERSION="14.0.4"
CRATE_CHECKSUM="c2bb772b3a26b8b71d4e8c112ced5b5867be2266364b58517407a270328a2696"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Common utilities for the swc project."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"__plugin"
	"__plugin_mode"
	"__plugin_rt"
	"__rkyv"
	"concurrent"
	"debug"
	"default"
	"diagnostic-serde"
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
