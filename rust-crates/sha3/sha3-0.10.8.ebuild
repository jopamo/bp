# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="sha3"
CRATE_VERSION="0.10.8"
CRATE_CHECKSUM="75872d278a8f37ef87fa0ddbda7802605cb18344497949862c0d4dcb291eba60"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of SHA-3, a family of Keccak-based hash functions including the SHAKE family of eXtendable-Output Functions (XOFs), as well as the accelerated variant TurboSHAKE"
HOMEPAGE="https://github.com/RustCrypto/hashes"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"asm"
	"default"
	"oid"
	"reset"
	"std"
)
