# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="p224"
CRATE_VERSION="0.13.2"
CRATE_CHECKSUM="30c06436d66652bc2f01ade021592c80a2aad401570a18aa18b82e440d2b9aa1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of the NIST P-224 (a.k.a. secp224r1) elliptic curve as defined in SP 800-186"
HOMEPAGE="https://github.com/RustCrypto/elliptic-curves/tree/master/p224"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"arithmetic"
	"default"
	"digest"
	"ecdh"
	"ecdsa"
	"pem"
	"pkcs8"
	"serde"
	"sha224"
	"std"
	"test-vectors"
)
