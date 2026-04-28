# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pkcs1"
CRATE_VERSION="0.7.5"
CRATE_CHECKSUM="c8ffb9f10fa047879315e6625af03c164b16962a5368d724ed16323b68ace47f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of Public-Key Cryptography Standards (PKCS) #1: RSA Cryptography Specifications Version 2.2 (RFC 8017)"
HOMEPAGE="https://github.com/RustCrypto/formats/tree/master/pkcs1"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"pem"
	"std"
	"zeroize"
)
