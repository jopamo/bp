# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="k256"
CRATE_VERSION="0.13.3"
CRATE_CHECKSUM="956ff9b67e26e1a6a866cb758f12c6f8746208489e3e4a4b5580802f2f0a587b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="secp256k1 elliptic curve library written in pure Rust with support for ECDSA signing/verification/public-key recovery, Taproot Schnorr signatures (BIP340), Elliptic Curve Diffie-Hellman (ECDH), and general-purpose secp256k1 elliptic curve group operations which can be used to implement arbitrary protocols"
HOMEPAGE="https://github.com/RustCrypto/elliptic-curves/tree/master/k256"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"arithmetic"
	"bits"
	"critical-section"
	"default"
	"digest"
	"ecdh"
	"ecdsa"
	"expose-field"
	"hash2curve"
	"jwk"
	"pem"
	"pkcs8"
	"precomputed-tables"
	"schnorr"
	"serde"
	"sha256"
	"std"
	"test-vectors"
)
