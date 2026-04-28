# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="aes"
CRATE_VERSION="0.8.3"
CRATE_CHECKSUM="ac1f845298e95f983ff1944b728ae08b8cebab80d684f0a832ed0fc74dfa27e2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of the Advanced Encryption Standard (a.k.a. Rijndael)"
HOMEPAGE="https://github.com/RustCrypto/block-ciphers"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"hazmat"
)
