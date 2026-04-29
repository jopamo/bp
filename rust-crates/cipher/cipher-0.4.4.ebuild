# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="cipher"
CRATE_VERSION="0.4.4"
CRATE_CHECKSUM="773f3b9af64447d2ce9850330c473515014aa235e6a783b02db81ff39e4a3dad"
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
	"rand_core"
	"std"
)
