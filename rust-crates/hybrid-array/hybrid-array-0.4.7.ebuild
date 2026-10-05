# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="hybrid-array"
CRATE_VERSION="0.4.7"
CRATE_CHECKSUM="e1b229d73f5803b562cc26e4da0396c8610a4ee209f4fac8fa4f8d709166dc45"
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
