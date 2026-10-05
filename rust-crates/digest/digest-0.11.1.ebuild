# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="digest"
CRATE_VERSION="0.11.1"
CRATE_CHECKSUM="285743a676ccb6b3e116bc14cc69319b957867930ae9c4822f8e0f54509d7243"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Traits for cryptographic hash functions and message authentication codes"
HOMEPAGE="https://github.com/RustCrypto/traits"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"block-api"
	"default"
	"dev"
	"getrandom"
	"mac"
	"oid"
	"rand_core"
	"zeroize"
)
