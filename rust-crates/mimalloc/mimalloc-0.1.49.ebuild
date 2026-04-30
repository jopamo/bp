# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="mimalloc"
CRATE_VERSION="0.1.49"
CRATE_CHECKSUM="aca3c01a711f395b4257b81674c0e90e8dd1f1e62c4b7db45f684cc7a4fcb18a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Performance and security oriented drop-in allocator"
HOMEPAGE="https://github.com/purpleprotocol/mimalloc_rust"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug"
	"debug_in_debug"
	"default"
	"extended"
	"local_dynamic_tls"
	"no_thp"
	"override"
	"secure"
	"v2"
)
