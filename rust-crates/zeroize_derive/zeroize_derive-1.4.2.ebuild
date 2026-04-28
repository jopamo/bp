# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zeroize_derive"
CRATE_VERSION="1.4.2"
CRATE_CHECKSUM="ce36e65b0d2999d2aafac989fb249189a141aee1f53c612c1f37d72631959f69"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Custom derive support for zeroize"
HOMEPAGE="https://github.com/RustCrypto/utils/tree/master/zeroize/derive"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
