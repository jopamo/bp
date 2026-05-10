# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="mimalloc"
CRATE_VERSION="0.1.47"
CRATE_CHECKSUM="b1791cbe101e95af5764f06f20f6760521f7158f69dbf9d6baf941ee1bf6bc40"
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
)
