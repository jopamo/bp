# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="signature"
CRATE_VERSION="2.2.0"
CRATE_CHECKSUM="77549399552de45a898a580c1b41d445bf730df867cc44e6c0233bbc4b8329de"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Traits for cryptographic signature algorithms (e.g. ECDSA, Ed25519)"
HOMEPAGE="https://github.com/RustCrypto/traits/tree/master/signature"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"std"
)
