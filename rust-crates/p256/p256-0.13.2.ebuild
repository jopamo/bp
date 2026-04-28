# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="p256"
CRATE_VERSION="0.13.2"
CRATE_CHECKSUM="c9863ad85fa8f4460f9c48cb909d38a0d689dba1f6f6988a5e3e0d31071bcd4b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of the NIST P-256 (a.k.a. secp256r1, prime256v1) elliptic curve as defined in SP 800-186, with support for ECDH, ECDSA signing/verification, and general purpose curve arithmetic"
HOMEPAGE="https://github.com/RustCrypto/elliptic-curves/tree/master/p256"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"arithmetic"
	"bits"
	"default"
	"digest"
	"ecdh"
	"ecdsa"
	"expose-field"
	"hash2curve"
	"jwk"
	"pem"
	"pkcs8"
	"serde"
	"sha256"
	"std"
	"test-vectors"
	"voprf"
)
