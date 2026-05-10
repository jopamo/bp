# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="libmimalloc-sys"
CRATE_VERSION="0.1.43"
CRATE_CHECKSUM="bf88cd67e9de251c1781dbe2f641a1a3ad66eaae831b8a2c38fbdc5ddae16d4d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Sys crate wrapping the mimalloc allocator"
HOMEPAGE="https://github.com/purpleprotocol/mimalloc_rust/tree/master/libmimalloc-sys"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"arena"
	"debug"
	"debug_in_debug"
	"extended"
	"local_dynamic_tls"
	"no_thp"
	"override"
	"secure"
)
