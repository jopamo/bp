# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="deno_graph"
CRATE_VERSION="0.111.1"
CRATE_CHECKSUM="8d88c8fda5602e366ff999b3b246cdbeca6a228f09370d5617eb20bab1ed0411"
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
