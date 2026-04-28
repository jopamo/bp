# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dsa"
CRATE_VERSION="0.6.3"
CRATE_CHECKSUM="48bc224a9084ad760195584ce5abb3c2c34a225fa312a128ad245a6b412b7689"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of the Digital Signature Algorithm (DSA) as specified in FIPS 186-4 (Digital Signature Standard), providing RFC6979 deterministic signatures as well as support for added entropy"
HOMEPAGE="https://github.com/RustCrypto/signatures/tree/master/dsa"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"std"
)
