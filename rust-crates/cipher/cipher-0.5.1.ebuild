# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cipher"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="e34d8227fe1ba289043aeb13792056ff80fd6de1a9f49137a5f499de8e8c78ea"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Traits for describing block ciphers and stream ciphers"
HOMEPAGE="https://github.com/RustCrypto/traits"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"block-padding"
	"dev"
	"getrandom"
	"rand_core"
	"stream-wrapper"
	"zeroize"
)
