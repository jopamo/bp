# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="hybrid-array"
CRATE_VERSION="0.4.11"
CRATE_CHECKSUM="08d46837a0ed51fe95bd3b05de33cd64a1ee88fc797477ca48446872504507c5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Hybrid typenum-based and const generic array types designed to provide the flexibility of typenum-based expressions while also allowing interoperability and a transition path to const generics"
HOMEPAGE="https://github.com/RustCrypto/hybrid-array"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"extra-sizes"
)
