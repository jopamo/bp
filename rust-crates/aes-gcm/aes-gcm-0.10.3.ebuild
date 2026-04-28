# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="aes-gcm"
CRATE_VERSION="0.10.3"
CRATE_CHECKSUM="831010a0f742e1209b3bcea8fab6a8e149051ba6099432c8cb2cc117dec3ead1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of the AES-GCM (Galois/Counter Mode) Authenticated Encryption with Associated Data (AEAD) Cipher with optional architecture-specific hardware acceleration"
HOMEPAGE="https://github.com/RustCrypto/AEADs"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"arrayvec"
	"default"
	"getrandom"
	"heapless"
	"rand_core"
	"std"
	"stream"
)
