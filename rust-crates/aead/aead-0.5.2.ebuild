# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="aead"
CRATE_VERSION="0.5.2"
CRATE_CHECKSUM="d122413f284cf2d62fb1b7db97e02edb8cda96d769b16e443a4f6195e35662b0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Traits for Authenticated Encryption with Associated Data (AEAD) algorithms, such as AES-GCM as ChaCha20Poly1305, which provide a high-level API"
HOMEPAGE="https://github.com/RustCrypto/traits"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"dev"
	"getrandom"
	"rand_core"
	"std"
	"stream"
)
