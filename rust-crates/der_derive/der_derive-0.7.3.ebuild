# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="der_derive"
CRATE_VERSION="0.7.3"
CRATE_CHECKSUM="8034092389675178f570469e6c3b0465d3d30b4505c294a6550db47f3c17ad18"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Custom derive support for the `der` crate's `Choice` and `Sequence` traits"
HOMEPAGE="https://github.com/RustCrypto/formats/tree/master/der/derive"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
