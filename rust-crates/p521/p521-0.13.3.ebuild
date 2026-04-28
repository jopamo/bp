# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="p521"
CRATE_VERSION="0.13.3"
CRATE_CHECKSUM="0fc9e2161f1f215afdfce23677034ae137bbd45016a880c2eb3ba8eb95f085b2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of the NIST P-521 (a.k.a. secp521r1) elliptic curve as defined in SP 800-186"
HOMEPAGE="https://github.com/RustCrypto/elliptic-curves/tree/master/p521"
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
	"getrandom"
	"hash2curve"
	"jwk"
	"pem"
	"pkcs8"
	"serde"
	"sha512"
	"std"
	"test-vectors"
	"voprf"
)
