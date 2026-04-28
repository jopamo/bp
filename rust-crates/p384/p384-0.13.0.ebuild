# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="p384"
CRATE_VERSION="0.13.0"
CRATE_CHECKSUM="70786f51bcc69f6a4c0360e063a4cac5419ef7c5cd5b3c99ad70f3be5ba79209"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of the NIST P-384 (a.k.a. secp384r1) elliptic curve as defined in SP 800-186 with support for ECDH, ECDSA signing/verification, and general purpose curve arithmetic support."
HOMEPAGE="https://github.com/RustCrypto/elliptic-curves/tree/master/p384"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

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
	"sha384"
	"std"
	"test-vectors"
	"voprf"
)
