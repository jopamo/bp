# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="deno_graph"
CRATE_VERSION="0.111.0"
CRATE_CHECKSUM="74d39f55639b6bffe4e886d2ea33724606729d3ec9c8e05a48952a56c1cef961"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Module graph analysis for deno"
HOMEPAGE="https://deno.land/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"ecosystem_test"
	"fast_check"
	"swc"
	"symbols"
)
